class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, RakeTestHelper

  protected

  def authenticate!
    redirect_to login_path unless warden.authenticated?
  end

  def current_user
    warden.user
  end

  def warden
    request.env["warden"]
  end
end
