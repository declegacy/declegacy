class ApplicationMailer < ActionMailer::Base
  default from: "postmaster@#{ENV['MAILGUN_DOMAIN']}"
  layout "mailer"

  helper :application
end
