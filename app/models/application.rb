class Application < ActiveRecord::Base
  attr_accessible :email, :name, :url
  
  validates_presence_of :email, :message => 'Please make sure you have entered the required fields.'
  validates_presence_of :name, :message => 'Please make sure you have entered the required fields.'
  validates_presence_of :url, :message => 'Please make sure you have entered the required fields.'
  validates_format_of :url, :with => URI.regexp, :on => :create, :message => "doesn't look like quite right"
  validates_uniqueness_of :email, :on => :create, :message => "Looks like someone with that email has already applied! Oh no!"
end
