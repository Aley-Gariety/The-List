class Gift < ActiveRecord::Base
attr_accessible :email, :karma, :gift, :username, :password, :password_salt

set_table_name "users"

before_create { generate_token(:auth_token) }

before_create { generate_token(:gift_token) }


	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
			end while User.exists?(column => self[column])
		end

		def send_gift(email)

		end
end