class VoteController < ApplicationController
	def upvote_post
  	return false unless Vote.where(:user_id => current_user.id, :post_id => params[:post_id], :direction => 0).count == 0
	  @new_vote = Vote.find_or_initialize_by_post_id_and_user_id(:user_id => current_user.id, :post_id => params[:post_id])
	  @new_vote.update_attributes({
  	  :vote_type => 0,
  	  :direction => 0
	  })
	  @new_vote.save
	end

	def downvote_post
  	return false unless Vote.where(:user_id => current_user.id, :post_id => params[:post_id], :direction => 1).count == 0
	  @new_vote = Vote.find_or_initialize_by_post_id_and_user_id(:user_id => current_user.id, :post_id => params[:post_id])
	  @new_vote.update_attributes({
  	  :vote_type => 0,
  	  :direction => 1
	  })
	  @new_vote.save
	end

	def upvote_comment
  	return false unless Vote.where(:user_id => current_user.id, :post_id => params[:post_id], :direction => 0).count == 0
	  @vote = Vote.new(:vote_type => 1, :direction => 0, :user_id => current_user.id, :post_id => params[:post_id])

    @vote.save
	end

	def downvote_comment
  	return false unless Vote.where(:user_id => current_user.id, :post_id => params[:post_id], :direction => 1).count == 0
	  @vote = Vote.new(:vote_type => 1, :direction => 1, :user_id => current_user.id, :post_id => params[:post_id])

    @vote.save
	end
end