class AddTestSuiteToTestCases < ActiveRecord::Migration[5.0]
  def change
    add_reference :test_cases, :test_suite, foreign_key: true
  end
end
