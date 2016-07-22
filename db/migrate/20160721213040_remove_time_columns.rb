class RemoveTimeColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :test_suite_runs, :time
    remove_column :test_case_runs, :time
    add_column :test_suite_runs, :time, :float
    add_column :test_case_runs, :time, :float
  end
end
