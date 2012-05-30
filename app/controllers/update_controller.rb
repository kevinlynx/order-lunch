class UpdateController < ApplicationController
  before_filter :auth

  def update
    do_update
    respond_to do |format|
      format.html { redirect_to root_path, :notice => "update done!" }
    end
  end

  private
    def auth
      authenticate_user!
      unless current_user.admin?
        respond_to do |format|
          format.html { redirect_to root_path, :notice => "need an admin" }
        end
      end
    end

    def do_update
      # 5.30.2012 v4, delete these test users
      #User.find(20).destroy 
      #User.find(4).destroy 
      #User.find(3).destroy 
      # 5.30.2012 v3, change user remain money log
      #MoneyLog.all.each do |log|
      #  log.remain = log.remain * 100
        #log.save
      #end

      # 5.30.2012 v2, change user money log
      #MoneyLog.all.each do |log|
      #  log.value = log.value * 100
      #  log.save
      #end
      # 5.30.2012 v1, update user money multiply by 100
      #User.all.each do |user|
       # unless user.admin?
       #   user.money = user.money * 100
       #   user.save
       # end
      #end 
    end
end

