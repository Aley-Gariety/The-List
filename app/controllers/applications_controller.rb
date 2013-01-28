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
    
    respond_to do |format|
    if Application.create (params[:application])
      format.html { redirect_to root_url, :notice => "Your application has been submitted and will be reviewed."  }
      format.json { render json: @application, status: :created, location: @post }
    else
     format.html { render action: :new }
     format.json { render json: @application.errors, status: :unprocessable_entity }
     end
    end
  end
end
