class IssueMailer < ApplicationMailer
  def send(user)
    mail(to: user.notification_profile.email, subject: "Things are breaking!")
  end
end
