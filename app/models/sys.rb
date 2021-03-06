class Sys < ActiveRecord::Base
  def self.setup
    s = Sys.first
    if s.nil?
      s = Sys.create(:run => 0, :stop_hour => 0, :stop_min => 0, 
                     :visited_at => Time.now.utc)
    end
    s
  end

  def self.visit
    s = setup
    s.visited_at = Time.now.utc
    s.save
  end

  def self.start?
    setup.run > 0
  end

  def self.start
    s = setup
    s.run = 1
    s.save
  end

  def self.stop
    s = setup
    s.run = 0
    s.save
  end

  def self.stop_time
    s = setup
    return s.stop_hour, s.stop_min
  end

  def self.set_stop_time(hour, min)
    s = setup
    s.stop_hour = hour
    s.stop_min = min
    s.save
  end

  def self.remain_time
    s = setup
    return 0 if s.stop_hour == 0 and s.stop_min == 0
    now = Time.now.utc
    future = Time.utc(now.year, now.month, now.day, s.stop_hour, s.stop_min)
    return 0 if future <= now
    # more than one day has been passed
    return 0 if future - s.visited_at >= 24 * 60 * 60
    future - now
  end

  def self.check_remain
    return -1 unless start?
    remain = remain_time
    if remain == 0 
      stop
    end
    remain
  end

  def self.local_to_utc(hour, min, zone)
    convert_time_in_zone(zone, ActiveSupport::TimeZone["UTC"], hour, min)
  end

  def self.utc_to_local(hour, min, zone)
    convert_time_in_zone(ActiveSupport::TimeZone["UTC"], zone, hour, min)
  end

  # convert `hour,min` in zone1 to zone2
  def self.convert_time_in_zone(zone1, zone2, hour, min)
    now = zone1.now
    future = zone1.local(now.year, now.month, now.day, hour, min)
    offset = future - now
    future_other = zone2.now + offset
    return future_other.hour, future_other.min 
  end
end
