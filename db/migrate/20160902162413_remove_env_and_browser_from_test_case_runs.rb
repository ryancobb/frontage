class RemoveEnvAndBrowserFromTestCaseRuns < ActiveRecord::Migration[5.0]
  def change
    remove_column :test_case_runs, :environment, :string
    remove_column :test_case_runs, :browser, :string
  end
end
