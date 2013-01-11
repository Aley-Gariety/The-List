class Vote < ActiveRecord::Base
  attr_accessible :direction, :post_id, :vote_type, :user_id
end