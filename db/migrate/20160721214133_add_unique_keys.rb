class AddUniqueKeys < ActiveRecord::Migration[5.0]
  def change
    add_index :test_cases, [:name, :test_suite_id], :unique => true
    add_index :test_suite_runs, [:timestamp, :test_suite_id], :unique => true
    add_index :test_suites, :name, :unique => true
  end
end
