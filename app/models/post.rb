class Post < ActiveRecord::Base
  attr_accessible :comment_count, :downvote, :id, :title, :upvote, :url, :user_id, :agreement

  has_many :votes

  has_many :comments

  belongs_to :user

  validates_presence_of :url, :on => :create
  validates_presence_of :title, :on => :create
  validates_acceptance_of :agreement, :on => :create, :message => "Please verify you have read the guidelines"
  validates_uniqueness_of :url, :on => :create, :message => "has already been submitted, try something fresssssshhhhhh"
  validates_format_of :url, :with => URI.regexp, :on => :create, :message => "doesn't look like quite right"
end
