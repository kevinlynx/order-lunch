@@sys_status = false
class HomeController < ApplicationController

  before_filter :authenticate_user!

  def index
    @foods = Food.all()
    @orders = current_user.orders
  end

  def stat
    @foods = Food.all()
    @users = User.all()
    @orders = current_user.orders
  end

  def user_stat
    @users = User.all()
  end

  def system
    s = params[:flag].to_i
    tip = ""
    if s > 0 
      @@sys_status = true
      tip = "start success"
    else
      @@sys_status = false
      tip = "stop success"
    end
    respond_to do |format|
      format.html { redirect_to root_path, :notice => tip }
    end
  end

  def self.sys_status
    @@sys_status
  end
end

