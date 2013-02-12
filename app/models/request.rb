class Request < ActiveRecord::Base
  attr_accessible :email, :name, :url, :listme
  include Rakismet::Model
  rakismet_attrs :name => "content"

  validates_presence_of :email
  validates_presence_of :name
  validates_format_of :email, :with => /@/
  validate :spam
  
  
  def spam
    if ['viagra','online','cialis','buy'].any? { |w| name.downcase =~ /#{w}/ }
      errors.add(:name, ' is spam?')
    end
  end
end
