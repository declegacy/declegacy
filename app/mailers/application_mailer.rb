class ApplicationMailer < ActionMailer::Base
  default from: "noreply@declegacy.com"
  layout "mailer"

  helper :application
end
