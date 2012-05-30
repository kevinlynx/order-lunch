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
      # 5.30.2012 v1, update user money multiply by 100
      User.all.each do |user|
        unless user.admin?
          user.money = user.money * 100
          user.save
        end
      end 
    end
end

