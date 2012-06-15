class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
    def permission_check
      authenticate_user!
      unless current_user.admin?
        respond_to do |format|
          format.html { redirect_to root_path, :notice => 'you are not admin' }
        end
      end
    end
end
