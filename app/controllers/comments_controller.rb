class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  def create
    @comment = Comment.new(params[:comment].merge(:user_id => current_user.id))

    respond_to do |format|
	    if @comment.save

        @post = Post.find(@comment.post_id)

        @post.update_attributes({
      	  :comment_count => @post.comment_count + 1
    	  })

        format.html { redirect_to @post }
        format.json { render json: @post, status: :created, location: @post }
      end
	  end
	end
end