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
      STDOUT << "WTF: " + resource.to_s + "\n"
      if resource.is_a?(Admin)
        STDOUT << "IS ADMIN\n"
        admin_dashboard_path
      elsif resource.is_a?(Editor)
        STDOUT << "IS EDITOR\n"
        editor_dashboard_path
      else
        STDOUT << "IS USER\n"
        # users_path
        request.referrer
      end
    end

    def current_auth_resource
      if admin_signed_in?
        current_admin
      elsif editor_signed_in?
        current_editor
      else
        current_user
      end
    end

    def render_error(status, exception)
      respond_to do |format|
        format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
        format.all { render nothing: true, status: status }
      end
    end
end
