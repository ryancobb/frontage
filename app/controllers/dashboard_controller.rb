class DashboardController < ApplicationController
  before_action :authenticate!

  def index
    @test_suites = TestSuite.includes(:test_suite_runs)
    @issues = Issue.active_issues
  end
end
