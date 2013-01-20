class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
 	 end
 	   
  def create
    @comment = Comment.new(params[:comment].merge(:user_id => current_user.id, :post_id => params[:post_id]))
    
    if @comment.save
        format.html { redirect_to @post }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
   end
end