class CreateTestSuiteRuns < ActiveRecord::Migration[5.0]
  def change
    create_table :test_suite_runs do |t|
      t.integer :tests
      t.time :time
      t.integer :failures
      t.integer :errs
      t.integer :skipped
      t.datetime :timestamp
      t.references :test_suite, foreign_key: true

      t.timestamps
    end
  end
end
