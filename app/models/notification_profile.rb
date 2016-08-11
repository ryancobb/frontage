class NotificationProfile < ApplicationRecord
  belongs_to :user

  validates_presence_of :slack, :if => :slack_enabled?
  validates_presence_of :email, :if => :email_enabled?
  validates_presence_of :sms, :if => :sms_enabled?
end
