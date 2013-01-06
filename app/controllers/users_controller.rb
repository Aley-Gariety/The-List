class UsersController < ApplicationController
	def new
	  @user = User.new
	end

	def create
	  @user = User.new(params[:user])
	  if @user.save
	    redirect_to root_url, :notice => "Signed up!"
	  else
	    render "new"
	  end
	end

	def profile
	  @current_user ||= User.find(session[:user_id])
	  if session[:user_id] == nil
	  redirect_to 'http://google.com'
	  end
  end
end
