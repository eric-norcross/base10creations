class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def home
    render '/pages/home'
  end
end
