class UsersController < ApplicationController

  skip_before_filter :require_login, :except => [:gift,:profile]

  #for adding a new user
	def new
	  @user = User.new
	end


	def create
	  @user = User.new(params[:user])
	  if @user.save

	    redirect_to root_url
	  else
	    render "new"
	  end
	end

  def send_gift(email,karma,new_gift_token,sender)
  	new_gift_token = SecureRandom.urlsafe_base64
		@new_user = User.new
		@new_user.save
	  Invite.gift(email, karma, new_gift_token, sender).deliver
  end

	def profile
	  @current_user ||= User.find(session[:user_id])
  end
end
