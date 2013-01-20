class Comment < ActiveRecord::Base
  attr_accessible :body, :downvotes, :post_id, :upvotes, :user_id
  
  validates_uniqueness_of :body, :on => :create, :message => "You can't comment the same thing twice!"
  
end
