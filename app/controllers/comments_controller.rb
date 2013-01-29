class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment].merge(:user_id => current_user.id))

    respond_to do |format|
	    if @comment.save
	    	@mixpanel = Mixpanel::Tracker.new "15c792135a188f39a0b6875a46a28d74"
    	  @mixpanel.track 'comment', { :username => current_user.username }

        @post = Post.find(@comment.post_id)

        @post.update_attributes({
      	  :comment_count => @post.comment_count + 1
    	  })
    	  
#    	  finding_regex = /^(?!.*\bRT\b)(?:.+\s)?@\w+/i
    	  
#     	  if params[:body].match(finding_regex)
#     	  	mentioned_users = params[:body].match(finding_regex).to_s
#     	  	matches = params[:body].match(finding_regex)
#     	  	if mentioned_users = matches.to_s?
#     	  	
#     	  	mentioned_users.each do |u|
#     	  		Invite.notify(0, User.find_by_username(u.sub!(/@/,'')).email, current_user.username).deliver
#     	  		end
#     	  	end
#     	  end
 
        format.html { redirect_to @post }
        format.json { render json: @post, status: :created }
      end
	  end
	end
end