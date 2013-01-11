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

  def gift
	  @user = User.new
  end

	def profile
	  @current_user ||= User.find(session[:user_id])
  end

end
