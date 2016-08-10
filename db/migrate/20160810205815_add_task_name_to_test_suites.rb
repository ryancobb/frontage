class AddTaskNameToTestSuites < ActiveRecord::Migration[5.0]
  def change
    add_column :test_suites, :task_name, :string
  end
end
