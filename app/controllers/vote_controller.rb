class VoteController < ApplicationController
	def upvote_post
  	return false unless Vote.where(:user_id => current_user.id, :post_id => params[:post_id], :vote_type => 0, :direction => 0).count == 0

  	value = current_user.karma * 0.02
  	value = 1 if value < 1

	  @new_vote = Vote.find_or_initialize_by_post_id_and_user_id_and_vote_type(:user_id => current_user.id, :post_id => params[:post_id], :vote_type => 0, :value => value)

  	orig_direction = @new_vote.direction

	  @new_vote.update_attributes({
  	  :direction => 0
	  })

	  if @new_vote.save

	    value = @new_vote.value unless @new_vote.new_record?
 	    value = value * 2 if (@new_vote.direction == 1 && orig_direction == 0) || (@new_vote.direction == 0 && orig_direction == 1)

	    receiving_user = User.find(Post.find(params[:post_id]).user_id)

  	  receiving_user.update_attributes({
    	  :karma => receiving_user.karma + value
  	  })
	  end
	end

	def downvote_post
  	return false unless Vote.where(:user_id => current_user.id, :post_id => params[:post_id], :vote_type => 0, :direction => 1).count == 0

  	value = current_user.karma * 0.02
  	value = 1 if value < 1

	  @new_vote = Vote.find_or_initialize_by_post_id_and_user_id_and_vote_type(:user_id => current_user.id, :post_id => params[:post_id], :vote_type => 0, :value => value)

  	orig_direction = @new_vote.direction

	  @new_vote.update_attributes({
  	  :direction => 1
	  })

	  if @new_vote.save

	    value = @new_vote.value unless @new_vote.new_record?
 	    value = value * 2 if (@new_vote.direction == 1 && orig_direction == 0) || (@new_vote.direction == 0 && orig_direction == 1)

	    receiving_user = User.find(Post.find(params[:post_id]).user_id)

  	  receiving_user.update_attributes({
    	  :karma => receiving_user.karma - value
  	  })
	  end
	end

# 	def upvote_comment
#   	return false unless Vote.where(:user_id => current_user.id, :post_id => params[:post_id], :vote_type => 1, :direction => 0).count == 0
#
#   	value = current_user.karma * 0.02
#   	value = 1 if value < 1
#
# 	  @new_vote = Vote.find_or_initialize_by_post_id_and_user_id_and_vote_type(:user_id => current_user.id, :post_id => params[:post_id], :vote_type => 1, :value => value)
#
#   	orig_direction = @new_vote.direction
#
# 	  @new_vote.update_attributes({
#   	  :direction => 0
# 	  })
#
# 	  if @new_vote.save
#
# 	    value = @new_vote.value unless @new_vote.new_record?
# 	    value = value * 2 if @new_vote.direction != orig_direction
#
# 	    receiving_user = User.find(Post.find(params[:post_id]).user_id)
#
#   	  receiving_user.update_attributes({
#     	  :karma => receiving_user.karma + value
#   	  })
# 	  end
# 	end
#
# 	def downvote_comment
#   	return false unless Vote.where(:user_id => current_user.id, :post_id => params[:post_id], :vote_type => 1, :direction => 1).count == 0
#
#   	value = current_user.karma * 0.02
#   	value = 1 if value < 1
#
# 	  @new_vote = Vote.find_or_initialize_by_post_id_and_user_id_and_vote_type(:user_id => current_user.id, :post_id => params[:post_id], :vote_type => 1, :value => value)
#
#   	orig_direction = @new_vote.direction
#
# 	  @new_vote.update_attributes({
#   	  :direction => 1
# 	  })
#
# 	  if @new_vote.save
#
# 	    value = @new_vote.value unless @new_vote.new_record?
# 	    value = value * 2 if @new_vote.direction != orig_direction
#
# 	    receiving_user = User.find(Post.find(params[:post_id]).user_id)
#
#   	  receiving_user.update_attributes({
#     	  :karma => receiving_user.karma - value
#   	  })
# 	  end
# 	end
end