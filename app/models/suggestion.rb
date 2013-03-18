class Suggestion < ActiveRecord::Base
  attr_accessible :comment_count, :text, :title, :user_id
end
