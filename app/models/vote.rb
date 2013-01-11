class Vote < ActiveRecord::Base
  attr_accessible :direction, :post_id, :type, :user_id
end
