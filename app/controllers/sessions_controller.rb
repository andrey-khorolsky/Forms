class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    session[:user_token] = auth.credentials.token
    session[:user_email] = auth.info.email
    redirect_to surveys_path
  end

  def destroy
    reset_session
    redirect_to surveys_path
  end
end
