class CreateTestCaseRuns < ActiveRecord::Migration[5.0]
  def change
    create_table :test_case_runs do |t|
      t.references :test_case, foreign_key: true
      t.time :time
      t.integer :status
      t.string :status_msg

      t.timestamps
    end
  end
end
