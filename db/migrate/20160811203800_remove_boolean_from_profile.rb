class RemoveBooleanFromProfile < ActiveRecord::Migration[5.0]
  def change
    change_table :notification_profiles do |t|
      t.remove :email_enabled
      t.remove :sms_enabled
      t.remove :slack_enabled
    end
  end
end
