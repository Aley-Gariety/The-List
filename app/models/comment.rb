class Comment < ActiveRecord::Base
  attr_accessible :comment_id, :downvote, :parent_id, :post_id, :text, :upvote, :user

  belongs_to :users

  belongs_to :posts

  has_many :votes
end
