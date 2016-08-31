class TestCasesController < ApplicationController
  before_action :set_test_case, only: []

  # GET /test_cases/1
  # GET /test_cases/1.json
  def show
    @test_case = TestCase.includes(:test_case_runs => :test_suite_run).find(params[:id])

    @passing_rate = calculate_passing_rate
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_case
      @test_case = TestCase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_case_params
      params.fetch(:test_case, {})
    end

    def calculate_passing_rate
      ((@test_case.test_case_runs.where(:status => 1).count/@test_case.test_case_runs.count.to_f)*100).round(2)
    end
end
