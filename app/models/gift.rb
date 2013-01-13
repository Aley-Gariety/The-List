class Gift < ActiveRecord::Base
  attr_accessible :email, :karma, :gift, :gift_token

  set_table_name "users"

  validates_presence_of :email
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Gift.exists?(column => self[column])
  end

end