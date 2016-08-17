class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.references :test_suite, foreign_key: true
      t.integer :num_of_occurences
      t.integer :claimed_by
      t.boolean :active

      t.timestamps
    end
  end
end
