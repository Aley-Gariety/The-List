class Gift < ActiveRecord::Base
  attr_accessible :email, :good_karma

  set_table_name "users"

  validates_presence_of :email

end