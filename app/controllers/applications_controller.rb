class ApplicationsController < ApplicationController

  skip_before_filter :require_login, :except => [:apply, :applications, :index]

  #for adding a new user
	def new
    respond_to do |format|
      @application = Application.new
      format.html # new.html.erb
      format.json { render json: @application }
    end
	end

	def create
    @application = Application.create params[:application]

    	if Application.create params[:application]
    	redirect_to root_url, :notice => "Your application has been submitted and will be reviewed."
    else
    	render :action => :new
    end

	end
end
