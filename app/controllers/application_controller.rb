class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :current_user

	before_filter :require_login, :free_invites

	private

	@@free_invites = false

	def current_user
	  @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
	end

  def require_login
  	unless current_user
  		redirect_to signin_url
  	end
  end

  def free_invites
    if [2,7,18,28].any? { |t| t == Time.now.day}
      @@free_invites = true

      flash.now[:free_invites] = "It's free invite day! <a href=\"/gift\">Send up to 4 karma for no cost.</a>".html_safe
    end
  end
end
