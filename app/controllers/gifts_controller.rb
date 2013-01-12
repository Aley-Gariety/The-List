class GiftsController < ApplicationController

  skip_before_filter :require_login, :except => :gift

  #for adding a new gift

   def gift
	  @gift = Gift.new
  end

	def create
	  @gift = Gift.new(params[:gift])
	  if @gift.save

	    redirect_to root_url
	  else
	    render "gift"
	  end
	end
end
