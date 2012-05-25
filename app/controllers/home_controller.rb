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
end

