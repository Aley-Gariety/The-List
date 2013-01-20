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
	    
	      Post.find(@comment.post_id).update_attributes({
      	  :comment_count => 1
    	  })
    	  
    	  @post = Post.find(@comment.post_id)
	    
        format.html { redirect_to @post }
        format.json { render json: @post, status: :created, location: @post }
      end
	  end
	end
end