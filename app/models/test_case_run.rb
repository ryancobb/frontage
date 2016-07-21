class TestCaseRun < ApplicationRecord
  belongs_to :test_case
  belongs_to :test_suite_run
end
