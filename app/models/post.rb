class Post < ActiveRecord::Base
  attr_accessible :comment_count, :downvote, :id, :text, :title, :upvote, :url, :user, :username

  has_many :votes

  has_many :comments

  belongs_to :users
end
