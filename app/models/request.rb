class Request < ActiveRecord::Base
  attr_accessible :email, :name, :url
end
