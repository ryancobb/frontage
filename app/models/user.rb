class User < ApplicationRecord
  has_one :notification_profile, :dependent => :destroy
  has_many :notifications, :dependent => :destroy

  accepts_nested_attributes_for :notification_profile, :notifications

  def full_name
    "#{first_name} #{last_name}"
  end
end
