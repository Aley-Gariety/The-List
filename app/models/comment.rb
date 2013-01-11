class Comment < ActiveRecord::Base
  attr_accessible :comment_id, :downvote, :parent_id, :post_id, :text, :upvote, :user_id

  belongs_to :user

  belongs_to :post

  has_many :votes
end
