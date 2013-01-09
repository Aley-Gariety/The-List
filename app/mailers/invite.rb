class Invite < ActionMailer::Base
  default from: "invites@organichackers.com"
  
  def invite
    mail(:to => "colbyaley@gmail.com", :subject => "You have an invite!")
  end
end