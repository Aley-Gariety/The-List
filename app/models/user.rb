class User < ActiveRecord::Base
  attr_accessible :bad_karma, :creation, :email, :full_name, :good_karma, :influence, :last_login, :password, :saved, :site, :username
end
