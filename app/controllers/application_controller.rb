class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

	before_filter :require_login

	private

	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

  def require_login
  	unless current_user
  		redirect_to log_in_url
  	end
  end
end
