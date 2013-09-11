class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def current_ability
    @current_ability ||= Ability.new(current_auth_resource)
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end

  # rescue_from Exception, with: lambda { |exception| render_error 500, exception }
  # rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }

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

    def render_error(status, exception)
      respond_to do |format|
        format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
        format.all { render nothing: true, status: status }
      end
    end
end
