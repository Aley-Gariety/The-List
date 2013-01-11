class Post < ActiveRecord::Base
  attr_accessible :comment_count, :downvote, :id, :text, :title, :upvote, :url, :user_id, :username, :agreement

  has_many :votes

  has_many :comments

  belongs_to :user

  validate :hasduekarma
  validates_presence_of :url, :on => :create, :message => "We need a URL"
  validates_presence_of :title, :on => :create, :message => "We need a title"
  validates_acceptance_of :agreement, :on => :create, :message => "Please verify you have read the guidelines"
  validates_uniqueness_of :url, :on => :create, :message => "That URL has already been submitted, try something fresssssshhhhhh"
  validates_format_of :url, :with => URI.regexp, :on => :create, :message => "That doesn't look like a URL"

  def hasduekarma
    errors.add(:all, "You have less than 10 karma")
  end
end
