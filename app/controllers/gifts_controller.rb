class GiftsController < ApplicationController

  skip_before_filter :require_login, :except => :gift

  #for adding a new gift

   def gift
	  @gift = Gift.new
  end

	def create
	  @gift = Gift.new(params[:gift].merge(:gift_token => gift.gift_token))
	  if @gift.save
	  Invite.gift(@gift).deliver

	    redirect_to root_url
	  else
	    render "gift"
	  end
	end
end
