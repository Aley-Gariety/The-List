ActionMailer::Base.smtp_settings = {
  :address              => "smtp.mailgun.org",
  :port                 => 587,
  :domain               => "thelistio.mailgun.org",
  :user_name            => "postmaster@thelistio.mailgun.org",
  :password             => "43kf8ja8t436",
  :authentication       => "plain",
  :enable_starttls_auto => true
}