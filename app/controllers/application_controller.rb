class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

private
  def after_sign_in_path_for(resource)
    if resource.admin
      admins_path
    else
      request.referrer
    end
  end
end
