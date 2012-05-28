module ApplicationHelper
  def link_to_submit(text, options = {})
    link_to_function text, "$(this).closest('form').submit()", options
  end

  def all_remain_money
    users = User.all
    money = 0
    users.each do |user| 
      money += user.money unless user.admin?
    end
    money
  end

  def user_count
    cnt = 0
    User.all.each do |user|
      cnt += 1 unless user.admin?
    end
    cnt
  end

  def system_started?
    SystemStatus.start?
  end

  def to_beijing_time(time)
    zone = ActiveSupport::TimeZone.new('Beijing')
    time.in_time_zone(zone)
  end
end
