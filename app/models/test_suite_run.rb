class TestSuiteRun < ApplicationRecord
  belongs_to :test_suite

  has_many :test_case_runs
end
