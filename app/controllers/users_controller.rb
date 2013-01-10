class UsersController < ApplicationController

    skip_before_filter :require_login, :only => :new

#for adding a new user
	def new
	  @user = User.new
	end

	
	def create
	  @user = User.new(params[:user])
	  if @user.save
# 	  	Notifier.welcome().deliver # sends the email
# 	  	mail = Notifier.welcome()  # => a Mail::Message object
# 	  	mail.deliver
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
  end
  
  def gift
	  @user = User.new(params[:user])
  end
  
end
