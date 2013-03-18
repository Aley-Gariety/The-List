class UsersController < ApplicationController

  skip_before_filter :require_login, :except => [:new,:profile]
  before_filter :free_invites, :only => [:new]

  #for adding a new user
	def new
		email = params[:email]
		name = params[:name]

    respond_to do |format|
      @user = User.new
      format.html # new.html.erb
      format.json { render json: @user }
    end
	end

	def create
		email = params[:user][:email]
		karma = params[:user][:karma]
		name = params[:user][:name]

		generated_token = SecureRandom.urlsafe_base64

    @user = User.find_or_initialize_by_auth_token(:auth_token => generated_token, :karma => karma, :email => email)

    unless [email, karma, name].any?{|f| f.blank? } || karma.to_i < 0
      unless current_user.karma < karma.to_i
        found_user = User.find_by_email(email)

        unless current_user.email == email
          current_user.update_attributes({
            :karma => current_user.karma - karma.to_i + (@@free_invites == true && karma.to_i >= 4 ? 4 : 0)
          })

          @applicant = Request.find_by_email(email)
          @applicant.destroy if @applicant

          if found_user
            found_user.update_attributes({
              :karma => found_user.karma + karma.to_i
            })

            User.first.send_gift(email, karma, '', current_user.username, 1, name)
            redirect_to root_url, :notice => "Your karma has been gifted."
          elsif @user.save
       	    @mixpanel = Mixpanel::Tracker.new "15c792135a188f39a0b6875a46a28d74"
          	@mixpanel.track 'gift', { :karma => @user.karma }
            User.first.send_gift(email, karma, generated_token, current_user.username, 0, name)
            redirect_to root_url, :notice => "Your invite has been sent."
          end
        else
          redirect_to request.env["HTTP_REFERER"], :notice => "You can't gift yourself karma, sorry."
        end
      else
        redirect_to request.env["HTTP_REFERER"], :notice => "You have insufficient karma."
      end
    else
      redirect_to request.env["HTTP_REFERER"], :notice => "Ooops. You should check your form again."
    end
	end

	def user
    @user = User.find_by_username(params[:username])

    @posts = Post
      .joins("LEFT JOIN votes ON posts.id = votes.post_id")
      .select("posts.id," +
        "sum(if(vote_type = 0, if(direction = 0, value, -value),0)) as score," +
        "sum(if(vote_type = 0, if(direction = 0, value, 0),0)) as upvotes," +
        "sum(if(vote_type = 0, if(direction = 1, -value, 0),0)) as downvotes," +
        "posts.created_at," +
        "url," +
        "title," +
        "posts.user_id")
      .order("posts.created_at desc")
      .group("posts.id")
      .limit(15)

    @comments = Comment
      .joins("LEFT JOIN votes ON comments.id = votes.post_id")
      .select("comments.id," +
        "sum(if(vote_type = 1, if(direction = 0, value, if(direction is null, 0, -value)),0)) as score," +
        "sum(if(vote_type = 1, if(direction = 0, value, 0),0)) as upvotes," +
        "sum(if(vote_type = 1, if(direction = 1, -value, 0),0)) as downvotes," +
        "comments.post_id," +
        "comments.comment_type," +
        "comments.created_at," +
        "body," +
        "comments.user_id")
      .order("comments.created_at desc")
      .where(:user_id => @user.id)
      .group("comments.id")
      .limit(15)
  end

  def update
  	@auth_token = params[:auth_token]
  	@password = params[:password]

    @user = User.find_by_auth_token(@auth_token)

    if params.include?(:user)

      email = params[:user][:email]
      username = params[:user][:username]
      password = params[:user][:password]
      password_conf = params[:user][:password_confirmation]

      unless [email, username, password, password_conf].any?{|f| f.blank? }
        if username =~ /^[a-zA-Z0-9_-]*$/
          if email =~ /@/
          	password_salt = BCrypt::Engine.generate_salt

        	  if User.find_by_auth_token(params[:user][:auth_token]).update_attributes({
      	  	  	:email => params[:user][:email],
      	  	  	:username => params[:user][:username],
      	  	  	:password_hash => BCrypt::Engine.hash_secret(params[:user][:password], password_salt),
      	  	  	:password_salt => password_salt
      	  	  })

        	    cookies.delete(:auth_token)
         	    @mixpanel = Mixpanel::Tracker.new "15c792135a188f39a0b6875a46a28d74"
            	@mixpanel.track 'signup', { :username => username }

            	user = User.authenticate(params[:user][:email], params[:user][:password])
            	if user
                cookies.permanent[:auth_token] = user.auth_token
                redirect_to "/posts/new", :notice => "Your account has been created. Make your first submission!"
            	end
            end
          else
            redirect_to request.env["HTTP_REFERER"], :notice => "Not a valid email."
          end
        else
          redirect_to request.env["HTTP_REFERER"], :notice => "Usernames must only contain letters, numbers, underscores, and hyphens."
        end
      else
        redirect_to request.env["HTTP_REFERER"], :notice => "Ooops. You should check your form again."
      end
    else
      render :update
    end
  end
end
