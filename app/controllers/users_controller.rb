class UsersController < ApplicationController
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

	def profile
	  @current_user ||= User.find(session[:user_id])
	  if session[:user_id] == nil
	  redirect_to 'http://google.com'
	  end
	  if !current_user.good_karma.blank?
	  @karma = current_user.good_karma
	  else @karma = "0"
	  end
  end
end
