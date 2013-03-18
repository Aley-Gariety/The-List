module SuggestionsHelper

  def comment_count(post_id, comment_type)
  	amount = Comment.where(:post_id => post_id, :comment_type => comment_type).count
  	
  	if amount == 0
  		"Leave a Comment"
  	elsif amount == 1
  		"View 1 Comment"
  	else
  		"View " + amount.to_s + " Comments"
  	end
  end

end
