class AddEnvAndBrowserToTestSuiteAndTestCaseRuns < ActiveRecord::Migration[5.0]
  def change
    add_column :test_suite_runs, :environment, :string
    add_column :test_suite_runs, :browser, :string
    add_column :test_case_runs, :environment, :string
    add_column :test_case_runs, :browser, :string
  end
end
