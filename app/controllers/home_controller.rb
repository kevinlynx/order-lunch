class HomeController < ApplicationController
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
    if user_signed_in? and current_user.admin?
      s = params[:flag].to_i
      tip = "invalid request"
      if s > 0 and not SystemStatus.start?
        User.clear_orders
        SystemStatus.start
        tip = t "tip.start_success"
      elsif s == 0 and SystemStatus.start?
        User.commit_orders
        SystemStatus.stop
        tip = t "tip.stop_success"
      end
      respond_to do |format|
        format.html { redirect_to root_path, :notice => tip }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, :notice => "you're not admin!" }
      end
    end
  end
end

