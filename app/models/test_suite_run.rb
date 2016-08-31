class TestSuiteRun < ApplicationRecord
  belongs_to :test_suite
  has_many :test_case_runs

  def passed?
    if failures + errs == 0
      true
    else
      false
    end
  end

  def css_mapping
    self.passed? ? "table-success" : "table-danger"
  end
end
