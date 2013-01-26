class User < ActiveRecord::Base
#  has_secure_password

  attr_accessible :email, :password, :password_confirmation, :username, :karma, :gift_token, :auth_token, :password_hash, :password_salt

  has_many :posts

  has_many :comments

  has_many :votes

  before_update :encrypt_password

# 	validates_confirmation_of :password, :only => :update
# 	validates_presence_of :password, :on => :create, :only => :update
# 	validates_presence_of :username, :on => :create, :only => :update
# 	validates_uniqueness_of :username, :on => :create, :only => :update
# 	validates_format_of :email, :with => /@/

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if @password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(@password, password_salt)
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    Invite.password_reset(self).deliver
  end
  

	def send_gift(email, karma, gift_token, sender, bool, name)

	  sending_user = User.find_by_username(sender)

    sending_user.update_attributes({
      :karma => sending_user.karma - karma.to_i
    })

    if bool == 0
		  Invite.gift_invite(email, karma, gift_token, sender, name).deliver
		elsif bool == 1
		  Invite.gift(email, karma, gift_token, sender, name).deliver
		end
	end
end