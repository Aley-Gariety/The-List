class Vote < ActiveRecord::Base
  attr_accessible :direction, :post_id, :vote_type, :user_id

  belongs_to :users

  belongs_to :posts

  belongs_to :comments
end