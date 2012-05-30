class UsersController < ApplicationController
  def add_money
    user = User.find(params[:id])
    money = params[:add_money].to_f
    if money <= 0 
      tip = t 'tip.add_money_failed'
    else
      user.change_money(money, t("tip.add_money_log"))
      tip = t 'tip.add_money_success'
    end
    respond_to do |format|
      format.html { redirect_to user_stat_path, :notice => tip }
    end
  end

  def add_money_form
    @user = User.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def spend_money
    user = User.find(params[:id])
    money = -params[:spend_money].to_f
    desc = params[:spend_desc]
    if money >= 0 or desc == ""
      tip = t 'tip.spend_money_failed'
    else
      user.change_money(money, desc)
      tip = t 'tip.spend_money_success'
    end
    respond_to do |format|
      format.html { redirect_to user_stat_path, :notice => tip }
    end
  end

  def spend_money_form
    @user = User.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def history
    @user = User.find(params[:id])
    @money_logs = @user.money_logs
    @orders = @user.orders
  end

  def profile
    @user = User.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def profile_update
    @user = User.find(params[:id])
    if @user.update_with_password(params[:user])
      sign_in @user, :bypass => true
      redirect_to root_path, :notice => t('tip.update_success')
    else
      redirect_to root_path, :notice => t('tip.update_failed')
    end
  end
end

