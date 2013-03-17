class Request < ActiveRecord::Base
  attr_accessible :email, :name, :url, :listme
  include Rakismet::Model
  rakismet_attrs :name => "content"

  validates_presence_of :email
  validates_presence_of :name
  validates_format_of :email, :with => /@/
  validate :spamname
  validate :spamurl
  validate :honeypot
  
  
  def spamname
    if ['viagra','online','cialis','buy','sildenafil','levitra','cheap','buy','order','health'].any? { |w| name.downcase =~ /#{w}/ }
      errors.add(:name, ' is spam?')
    end
  end
  
  def spamurl
    if ['centerblog','pornhub'].any? { |w| url.downcase =~ /#{w}/ }
      errors.add(:url, ' is spam?')
    end
  end
end
