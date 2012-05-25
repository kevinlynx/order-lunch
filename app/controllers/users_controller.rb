class UsersController < ApplicationController
  def add_money
    user = User.find(params[:id])
    money = params[:add_money].to_i
    user.money += money
    user.save
    respond_to do |format|
      format.html { redirect_to user_stat_path, :notice => 'add money success' }
    end
  end

  def add_money_form
    @user = User.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
end

