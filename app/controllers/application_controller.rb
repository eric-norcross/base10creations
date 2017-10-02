class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :set_authenticated_layout

  protected
    def after_sign_in_path_for(resource)
      dashboard_path
    end
  
    def set_authenticated_layout
      # Rails::logger.debug "********************************"
      # Rails::logger.debug "#ApplicationController - {self.class.name} - params[:action]: #{params[:action]}"
      # Rails::logger.debug "********************************"

      if admin_signed_in? && params[:admin_scope].present?
        "admin"
      else 
        "application"
      end
    end
end
