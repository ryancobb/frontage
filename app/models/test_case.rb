class TestCase < ApplicationRecord
  belongs_to :test_suite

  has_many :test_case_runs

  def passing_rate
    test_case_runs = TestCaseRun.where(:test_case_id => self.id)

    count = test_case_runs.count
    passing = test_case_runs.where(:status => 1).count

    ((100 * passing) / count.to_f).round(2)
  end

  def average_time
    test_case_runs = TestCaseRun.where(:test_case_id => self.id)

    test_case_runs.average(:time).round(2)
  end
end
