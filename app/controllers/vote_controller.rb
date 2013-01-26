class VoteController < ApplicationController
  def vote
    user_id = current_user.id
    post_id = params[:post_id]
    vote_type = params[:vote_type]
    direction = params[:direction].to_i
    value = params[:value].to_i

  	return false unless Vote.where(:user_id => user_id, :post_id => post_id, :vote_type => vote_type, :direction => direction).count == 0 || (current_user.id == Post.find(post_id).user_id)

	  @new_vote = Vote.find_or_initialize_by_post_id_and_user_id_and_vote_type(:user_id => current_user.id, :post_id => post_id, :vote_type => vote_type, :value => value)

	  value *= 2 unless @new_vote.new_record?

	  @new_vote.update_attributes({
  	  :direction => direction
	  })

	  if @new_vote.save
	  	@mixpanel = Mixpanel::Tracker.new "15c792135a188f39a0b6875a46a28d74"
    	@mixpanel.track 'vote', { :username => current_user.username, :type => vote_type, :direction => direction, :post_id => post_id }

	    receiving_user = User.find(Post.find(post_id).user_id)

	    if direction == 0
	     change = receiving_user.karma + value
	    else
	     change = receiving_user.karma - value
	    end

  	  receiving_user.update_attributes({
    	  :karma => change
  	  })
	  end
  end
end