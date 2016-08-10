class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.text     "first_name"
      t.text     "last_name"
      t.text     "username"
      t.text     "email_address"
      t.datetime "created_at",    null: false
      t.datetime "updated_at",    null: false
      t.text     "role"
      t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
    end
  end
end
