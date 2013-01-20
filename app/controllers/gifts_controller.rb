class GiftsController < ApplicationController

  skip_before_filter :require_login, :except => [:gift, :redeem]  
		
	def index
	end
		
	def new
		@gift = Gift.new
	end
		
	def create
	 @gift = Gift.new()
	 if @gift.save
			user = User.first
			user.send_gift(params[:email], params[:karma], current_user.gift_token, current_user.email)
		  redirect_to root_url, :notice => "Your gift has been sent."
	 else
	 		render :new
	  end
	end
	
	def edit
	  @user = User.find_by_gift_token!(params[:id])
	end
	
	def redeem
	  @user = User.find_by_gift_token!(params[:id])
	  if @user.update_attributes(params[:user])
	    redirect_to root_url, :notice => "You account has been created"
	  else
	    render :edit
	  end
	end
end
