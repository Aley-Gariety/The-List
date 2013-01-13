class Gift < ActiveRecord::Base
  attr_accessible :email, :karma, :gift, :gift_token, :username, :password, :password_salt
  

  set_table_name "users"

  validates_presence_of :email
  validates :karma, :numericality => {:only_integer => true}
  
def send_gift
  generate_token(:password_reset_token)
  save!
  Invite.gift(self).deliver
end

def generate_token(column)
  begin
    self[column] = SecureRandom.urlsafe_base64
  end while User.exists?(column => self[column])
end

end