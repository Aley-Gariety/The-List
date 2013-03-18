class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :current_user, :detect_level

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
  
  def detect_level(user_id)
  	user = User.find(user_id)
  
   	if user.karma.between?(0, 24)
   		@@level = 0
   	elsif current_user && user.karma.between?(25, 49)
   		@@level = 1
   	elsif user.karma.between?(50, 99)
   		@@level = 2
   	elsif user.karma >= 100
   		@@level = 3
   	end
  end

end
