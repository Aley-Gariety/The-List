class UsersController < ApplicationController

  skip_before_filter :require_login, :except => [:new,:profile]

  #for adding a new user
	def new
	  @user = User.new
	end

	def create
    @user = User.find_or_initialize_by_email(:email => params[:email], :karma => params[:karma])

    user = User.first

    if @user.new_record? && @user.save
      user.send_gift(params[:email], params[:karma], User.find_by_email(params[:email]).gift_token, current_user.username, 0, params[:name])
      redirect_to root_url, :notice => "Your invite has been sent."
    elsif User.find_by_email(params[:email]) != nil
      user.send_gift(params[:email], params[:karma], current_user.gift_token, current_user.username, 1, params[:name])
      redirect_to root_url, :notice => "Your karma has been gifted."
    end

    @user.update_attributes({
      :karma => @user.karma + params[:karma].to_i
    })

	end

  def send_gift(email,karma,new_gift_token,sender)
  	new_gift_token = SecureRandom.urlsafe_base64
		@new_user = User.new
		@new_user.save
	  Invite.gift(email, karma, new_gift_token, sender).deliver
  end

	def user
    @user = User.find_by_username(params[:username])

    @posts = Post
    .where(:user_id => User.find_by_username(params[:username]).id)
    .joins("LEFT JOIN votes ON posts.id = votes.post_id")
    .select("posts.id," +
      "sum(if(direction = 0, value, if(direction is null, 0, -value))) as score," +
      "posts.created_at," +
      "url," +
      "title," +
      "posts.user_id," +
      "comment_count")
    .group("posts.id")
    .order("log10(abs(sum(if(direction = 0, value, if(direction is null, 0, -value)))) + 1) * sign(sum(if(direction = 0, value, if(direction is null, 0, -value)))) + (unix_timestamp(posts.created_at) / 300000) DESC")
  end
  
  def redeem
  	@token = params[:token]
    @user = User.find_by_gift_token!(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "You account has been created."
    else
      render :edit
    end
  end
end
