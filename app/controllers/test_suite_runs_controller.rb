class TestSuiteRunsController < ApplicationController
  before_action :set_test_suite_run, only: [:show]

  def index
    @test_suite_runs = TestSuiteRun.where(:test_suite_id => params[:test_suite_id]).order("id DESC").paginate(:page => params[:page])
  end

  def last_20_runs
    runs = TestSuite.find(params[:id]).test_suite_runs.order("id DESC").limit(30).reverse
    render :json => runs
  end

  # GET /test_suite_runs/1
  # GET /test_suite_runs/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_suite_run
      @test_suite_run = TestSuiteRun.includes(:test_case_runs => :test_case ).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_suite_run_params
      params.fetch(:test_suite_run, {})
    end

    def calculate_passing_rate
      passing_runs = @test_suite_runs.where(:errs => 0).count
      total_runs = @test_suite_runs.count
      
      ((passing_runs/total_runs.to_f)*100).round(2)
    end
end
