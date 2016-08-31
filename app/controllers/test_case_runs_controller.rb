class TestCaseRunsController < ApplicationController
  before_action :set_test_case_run, only: [:show, :edit, :update, :destroy]

  # GET /test_case_runs
  # GET /test_case_runs.json
  def index
    @test_case_runs = TestCaseRun.where(:test_case_id => params[:test_case_id]).order("id DESC")
  end

  # GET /test_case_runs/1
  # GET /test_case_runs/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_case_run
      @test_case_run = TestCaseRun.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_case_run_params
      params.fetch(:test_case_run, {})
    end
end
