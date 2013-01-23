class GiftsController < ApplicationController

  skip_before_filter :require_login, :except => [:gift, :redeem]

  def index
  end

  def new
    @gift = Gift.new
  end

  def create
    @gift = Gift.find_or_initialize_by_email(:email => params[:email], :karma => params[:karma])



    user = User.first

    if @gift.new_record? && @gift.save
      user.send_gift(params[:email], params[:karma], User.find_by_email(params[:email]).gift_token, current_user.username, 0, params[:name])
      redirect_to root_url, :notice => "Your invite has been sent."
    elsif User.find_by_email(params[:email]) != nil
      user.send_gift(params[:email], params[:karma], current_user.gift_token, current_user.username, 1, params[:name])
      redirect_to root_url, :notice => "Your karma has been gifted."
    end
    
    @gift.update_attributes({
      :karma => @gift.karma + params[:karma].to_i
    })
    
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
