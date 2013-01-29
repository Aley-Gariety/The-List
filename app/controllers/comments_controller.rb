class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment].merge(:user_id => current_user.id)).order("DESC")

    respond_to do |format|
	    if @comment.save
	    	@mixpanel = Mixpanel::Tracker.new "15c792135a188f39a0b6875a46a28d74"
    	  @mixpanel.track 'comment', { :username => current_user.username }

        @post = Post.find(@comment.post_id)

        @post.update_attributes({
      	  :comment_count => @post.comment_count + 1
    	  })

        format.html { redirect_to @post }
        format.json { render json: @post, status: :created }
      end
	  end
	end
end