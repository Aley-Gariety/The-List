class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :username, :good_karma, :bad_karma

  has_many :posts

  has_many :comments

  has_many :votes

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => :create
  validates_uniqueness_of :email, :on => :create
  validates_presence_of :username, :on => :create
  validates_uniqueness_of :username, :on => :create

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end