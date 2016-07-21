class TestSuite < ApplicationRecord
  has_many :test_suite_runs
  has_many :test_cases
end
