class VoteController < ApplicationController
	def upvote_post
  	return false unless Vote.where(:user_id => current_user.id, :post_id => params[:post_id], :vote_type => 0, :direction => 0).count == 0

  	value = current_user.karma * 0.02

  	value = 1 if value < 1

	  @new_vote = Vote.find_or_initialize_by_post_id_and_user_id_and_vote_type(:user_id => current_user.id, :post_id => params[:post_id], :vote_type => 0, :value => value)
	  @new_vote.update_attributes({
  	  :direction => 0
	  })

	  @new_vote.save
	end

	def downvote_post
  	return false unless Vote.where(:user_id => current_user.id, :post_id => params[:post_id], :vote_type => 0, :direction => 1).count == 0

  	value = current_user.karma * 0.02

  	value = 1 if value < 1

	  @new_vote = Vote.find_or_initialize_by_post_id_and_user_id_and_vote_type(:user_id => current_user.id, :post_id => params[:post_id], :vote_type => 0, :value => value)
	  @new_vote.update_attributes({
  	  :direction => 1
	  })

	  @new_vote.save
	end

	def upvote_comment
  	return false unless Vote.where(:user_id => current_user.id, :post_id => params[:post_id], :vote_type => 1, :direction => 0).count == 0

  	value = current_user.karma * 0.02

  	value = 1 if value < 1

	  @new_vote = Vote.find_or_initialize_by_post_id_and_user_id_and_vote_type(:user_id => current_user.id, :post_id => params[:post_id], :vote_type => 1, :value => value)
	  @new_vote.update_attributes({
  	  :direction => 0
	  })

	  @new_vote.save
	end

	def downvote_comment
  	return false unless Vote.where(:user_id => current_user.id, :post_id => params[:post_id], :vote_type => 1, :direction => 1).count == 0

  	value = current_user.karma * 0.02

  	value = 1 if value < 1

	  @new_vote = Vote.find_or_initialize_by_post_id_and_user_id_and_vote_type(:user_id => current_user.id, :post_id => params[:post_id], :vote_type => 1, :value => value)
	  @new_vote.update_attributes({
  	  :direction => 1
	  })

	  @new_vote.save
	end
end