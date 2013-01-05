class Post < ActiveRecord::Base
  attr_accessible :comment_count, :downvote, :id, :text, :title, :upvote, :url, :user
end
