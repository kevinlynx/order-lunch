class HomeController < ApplicationController
  def index
    @shops = Shop.all()
    @orders = current_user.orders if user_signed_in?
  end

  def faq
  end

  def stat
    @shops = Shop.all()
    @users = User.all()
    @orders = current_user.orders if user_signed_in?
  end

  def user_stat
    @users = User.all()
  end

  def system
    s = params[:flag].to_i
    tip = ""
    if s > 0 
      User.clear_orders
      SystemStatus.start
      tip = t "tip.start_success"
    else
      User.commit_orders
      SystemStatus.stop
      tip = t "tip.stop_success"
    end
    respond_to do |format|
      format.html { redirect_to root_path, :notice => tip }
    end
  end
end

