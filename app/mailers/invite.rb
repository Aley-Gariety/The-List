class Invite < ActionMailer::Base
  default from: "The List <postmaster@thelistio.mailgun.org>"

  def gift(email, karma, token, sender, name)
	  @email = email
	  @karma = karma
	  @token = token
	  @sender = sender
	  @name = User.find_by_email(email).username
	  mail :to => email, :subject => "Gift of karma on The List"
  end

  def gift_invite(email, karma, token, sender, name)
	  @email = email
	  @karma = karma
	  @token = token
	  @sender = sender
	  @name = name
	  mail :to => email, :subject => "Invitation to The List"
  end

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "The List - Password Reset"
  end

  def log(message)
    mail :to => "personal@jacksongariety.com", :subject => "The List - Log", :body => message
  end
  
  def notify(type,email,mentioner)
  	@type = type
  	@email = email
  	@mentioner = mentioner
  	
  	# mention
  	if type == 0
  		mail :to => email, :subject => "You've been mentioned on The List", :body => message
  	end
  end
end