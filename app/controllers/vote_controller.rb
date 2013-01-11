class VoteController < ApplicationController
	def upvote_post
  	#return false unless Vote.group(:user_id).where(:user_id => current_user.id) == nil
	  @vote = Vote.new(:type => 0, :direction => 0, :user_id => current_user.id, :post_id => params[:post_id])

    @vote.save
	end

	def downvote_post
	  @vote = Vote.new(:type => 0, :direction => 1, :user_id => current_user.id, :post_id => params[:post_id])

    @vote.save
	end

	def upvote_comment
	  @vote = Vote.new(:type => 1, :direction => 0, :user_id => current_user.id, :post_id => params[:post_id])

    @vote.save
	end

	def downvote_comment
	  @vote = Vote.new(:type => 1, :direction => 1, :user_id => current_user.id, :post_id => params[:post_id])

    @vote.save
	end
end