class CreateNotificationProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :notification_profiles do |t|
      t.references :user, foreign_key: true
      t.string :email
      t.string :sms
      t.string :slack
      t.boolean :email_enabled
      t.boolean :sms_enabled
      t.boolean :slack_enabled

      t.timestamps
    end
  end
end
