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
    	  
    	  if @comment.comment_type == 0
    	  	model = Post
    	  	vote_type = 1
    	  elsif @comment.comment_type == 1
    	  	model = Suggestion
    	  	vote_type = 3
    	  end

        @post = model.find(@comment.post_id)

    	  @new_vote = Vote.new(:post_id => @comment.id, :user_id => current_user.id, :vote_type => vote_type, :direction => 0, :value => 0)

    	  @new_vote.save

        format.html { redirect_to @comment.comment_type == 1 ? @post : @post }
        format.json { render json: @post, status: :created }
      end
	  end
	end
	
end