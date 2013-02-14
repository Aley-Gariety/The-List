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

    	  @new_vote = Vote.new(:post_id => @comment.id, :user_id => current_user.id, :vote_type => 1, :direction => 0, :value => 0)

    	  @new_vote.save

        format.html { redirect_to @post }
        format.json { render json: @post, status: :created }
      end
	  end
	end
	
end