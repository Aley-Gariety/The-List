class GiftsController < ApplicationController

  skip_before_filter :require_login, :except => [:gift, :redeem]
  
	
def gift
	@gift = Gift.new
end
	
def create
  user = User.find_by_email(params[:email])
  user.send_gift if user
  redirect_to root_url, :notice => "Your gift has been sent."
end

def edit
  @user = User.find_by_password_reset_token!(params[:id])
end

def redeem
  @user = User.find_by_password_reset_token!(params[:id])
  if @user.update_attributes(params[:user])
    redirect_to root_url, :notice => "You account has been created"
  else
    render :edit
  end
end
end
