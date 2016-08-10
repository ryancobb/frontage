class SessionsController < ::ApplicationController
  # GET /login
  def new
    flash[:error] = warden.message if warden.message
  end

  # POST /login
  def create
    warden.authenticate!(:ldap)
    flash.clear

    redirect_to root_path
  end

  # GET /logout
  def destroy
    warden.logout
    redirect_to login_path
  end
end
