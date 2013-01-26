class Comment < ActiveRecord::Base
  attr_accessible :body, :downvotes, :post_id, :upvotes, :user_id
  
  
end
