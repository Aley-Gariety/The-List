class Vote < ActiveRecord::Base
  attr_accessible :direction, :post_id, :vote_type, :user_id

  belongs_to :user

  belongs_to :post

  belongs_to :comments
end