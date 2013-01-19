class VoteController < ApplicationController
	def upvote_post
  	return false unless Vote.where(:user_id => current_user.id, :post_id => params[:post_id], :direction => 0).count == 0

	  if Vote.where(:user_id => current_user.id, :post_id => params[:post_id], :direction => 1).count == 1
	   increment = 2
	  else
	   increment = 1
	  end

	  @new_vote = Vote.find_or_initialize_by_post_id_and_user_id(:user_id => current_user.id, :post_id => params[:post_id])
	  @new_vote.update_attributes({
  	  :vote_type => 0,
  	  :direction => 0
	  })

	  User.find(current_user.id).update_attributes({
  	  :karma => current_user.karma + increment
	  })

	  @new_vote.save
	end

	def downvote_post
  	return false unless Vote.where(:user_id => current_user.id, :post_id => params[:post_id], :direction => 1).count == 0

	  if Vote.where(:user_id => current_user.id, :post_id => params[:post_id], :direction => 0).count == 1
	   increment = 2
	  else
	   increment = 1
	  end

	  @new_vote = Vote.find_or_initialize_by_post_id_and_user_id(:user_id => current_user.id, :post_id => params[:post_id])
	  @new_vote.update_attributes({
  	  :vote_type => 0,
  	  :direction => 1
	  })

	  User.find(current_user.id).update_attributes({
  	  :karma => current_user.karma - increment
	  })

	  @new_vote.save
	end

	def upvote_comment
	end

	def downvote_comment
	end
end