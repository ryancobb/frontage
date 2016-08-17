module Notifier
  def self.slack(users)

    users.each do |user|
      unless user.notification_profile.slack.nil?
      notifier = Slack::Notifier.new "https://hooks.slack.com/services/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", channel: user.notification_profile.slack,
                                                                                                                    username: "Frontage"
      notifier.ping "Hello! #{user.full_name}"
      end
    end

  end

  def self.email(users)

  end
end
