class AddTestSuiteRunToTestCaseRuns < ActiveRecord::Migration[5.0]
  def change
    add_reference :test_case_runs, :test_suite_run, foreign_key: true
  end
end
