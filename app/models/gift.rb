class Gift < ActiveRecord::Base
  attr_accessible :email, :karma, :gift, :gift_token, :username, :password, :password_salt
  
  before_save :encrypt_password

  set_table_name "users"

  validates_presence_of :email
  validates :karma, :numericality => {:only_integer => true}
  
  before_create { generate_token(:gift_token) }
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end