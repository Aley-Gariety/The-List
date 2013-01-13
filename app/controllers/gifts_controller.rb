class GiftsController < ApplicationController

  skip_before_filter :require_login, :except => [:gift, :redeem]
  
   def gift
	  @gift = Gift.new
  end

	def create
		@user = 'test'
	  @gift = Gift.new(params[:gift].merge(:gift_token => gift.gift_token))
	  if @gift.save
	  User.find(current_user.id).update_attributes({
      	  :karma => current_user.karma - @gift.karma
    	  })
	  	if Gift.where(:email => @gift.email).count == 0
	  		Invite.invite(@gift).deliver
	  	elsif Gift.where(:email => @gift.email).count >1
	  		Invite.gift(@gift).deliver
	  	end
	    redirect_to root_url
	  else
	    render "gift"
	  end
	end
	
	def redeem
		  @user = User.new
	end
end
