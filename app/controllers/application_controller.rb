class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

	before_filter :require_login

	private
  
  
  
	def current_user
	  @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
	end

  def require_login
  	unless current_user
  		redirect_to log_in_url
  	end
  end
end
