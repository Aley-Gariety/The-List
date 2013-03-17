class Request < ActiveRecord::Base
  attr_accessible :email, :name, :url, :listme
  include Rakismet::Model
  rakismet_attrs :name => "content"

  validates_presence_of :email
  validates_presence_of :name
  validates_presence_of :url
  validates_format_of :email, :with => /@/
end
