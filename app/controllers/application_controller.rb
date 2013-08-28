class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def current_ability
    @current_ability ||= Ability.new(current_auth_resource)
  end

private
  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_dashboard_path
    else
      # users_path
      request.referrer
    end
  end

  def current_auth_resource
    if admin_signed_in?
      current_admin
    else
      current_user
    end
  end
end
