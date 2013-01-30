ActionMailer::Base.smtp_settings = {
  :address              => "smtp.mailgun.org",
  :port                 => 587,
  :domain               => "thelist.io",
  :user_name            => "postmaster@thelist.io",
  :password             => "59us-2lmvri0",
  :authentication       => "plain",
  :enable_starttls_auto => true
}