class AdminsController < ApplicationController
  load_and_authorize_resource

  def dashboard
    render "admins/dashboard"
  end

  def index
    respond_to do |format|
      format.html
    end
  end

  def destroy
    @admin.destroy
    redirect_to admin_admins_path
  end
end
