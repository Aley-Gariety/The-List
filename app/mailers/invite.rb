class Invite < ActionMailer::Base
  default from: "timmy.wrinkle@gmail.com"

  def gift(gift)
    @gift = gift
    mail :to => gift.email, :subject => "The List - You have recieved a gift!", :body => "Welcome to the list!"
  end

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "The List - Password Reset"
  end

  def log(message)
    mail :to => "personal@jacksongariety.com", :subject => "The List - Log", :body => message
  end
end