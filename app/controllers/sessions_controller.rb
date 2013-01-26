class SessionsController < ApplicationController

  skip_before_filter :require_login

  def new
  end

  def create

    user = User.authenticate(params[:email], params[:password])
    if user
    	@mixpanel = Mixpanel::Tracker.new "15c792135a188f39a0b6875a46a28d74"
    	@mixpanel.track 'login', { :email => user.email }
      cookies.permanent[:auth_token] = user.auth_token
      redirect_to root_url
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url
  end
end