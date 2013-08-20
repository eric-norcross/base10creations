class AdminsController < ApplicationController
  load_and_authorize_resource

  def home
    render "admins/dashboard.html.haml"
  end
end
