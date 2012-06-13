class HomeController < ApplicationController
  before_filter :permission_check, :only => [:sys_setup, :system]

  def index
    @shops = Shop.all()
    @orders = current_user.orders if user_signed_in?
  end

  def faq
  end

  def stat
    @view_type = :stat
    @shops = Shop.all()
    @users = User.all()
    @orders = current_user.orders if user_signed_in?
  end

  def user_stat
    @users = User.all()
  end

  def system
    s = params[:flag].to_i
    tip = "invalid request"
    if Sys.remain_time == 0 
      tip = t 'tip.stop_time_invalid'
    elsif s > 0 and not Sys.start?
      User.clear_orders
      Sys.start
      tip = t "tip.start_success"
    elsif s == 0 and Sys.start?
      User.commit_orders
      Sys.stop
      tip = t "tip.stop_success"
    end
    respond_to do |format|
      format.html { redirect_to root_path, :notice => tip }
    end
  end

  def check_sys
    if Sys.check_remain == 0 
      User.commit_orders
    end
    respond_to do |format|
      format.html { redirect_to root_path, :notice => t('tip.system_stopped') }
    end
  end

  def sys_setup
    hour = params[:hour].to_i
    min = params[:min].to_i
    if hour < 0 or hour > 24 or min < 0 or min >= 60
      respond_to do |format|
        format.html { redirect_to root_path, :notice => 'invalid input' }
      end
    else
      zone_name = session[:zone_name] # it can be null and i donot know why
      zone_name = params[:zone_name] unless zone_name # so be sure it's correct
      zone = ActiveSupport::TimeZone[zone_name] if zone_name
      zone = ActiveSupport::TimeZone["UTC"] unless zone
      hour, min = Sys.local_to_utc(hour, min, zone)
      Sys.set_stop_time(hour, min)
      respond_to do |format|
        format.html { redirect_to root_path, :notice => t('tip.update_success') }
      end
    end
  end

  def timezone
      offset_sec = params[:offset_min].to_i * 60
      zone = ActiveSupport::TimeZone[offset_sec]
      zone = ActiveSupport::TimeZone["UTC"] unless zone
      session[:zone_name] = zone.name if zone
      respond_to do |format|
        format.js
      end
  end

  private
    def permission_check
      authenticate_user!
      unless current_user.admin?
        respond_to do |format|
          format.html { redirect_to root_path, :notice => 'you are not admin' }
        end
      end
    end
end

