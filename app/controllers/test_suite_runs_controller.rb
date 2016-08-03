class TestSuiteRunsController < ApplicationController
  before_action :set_test_suite_run, only: [:show, :edit, :update, :destroy]

  # GET /test_suite_runs
  # GET /test_suite_runs.json
  def index
    @test_suite = TestSuite.find(params[:test_suite_id])
    @test_suite_runs = @test_suite.test_suite_runs.order("timestamp DESC")

    @passing_rate = calculate_passing_rate

    respond_to do |format|
      format.html
      format.json { render json: @test_suite_runs }
    end
  end

  # GET /test_suite_runs/1
  # GET /test_suite_runs/1.json
  def show
  end

  # GET /test_suite_runs/new
  def new
    @test_suite_run = TestSuiteRun.new
  end

  # GET /test_suite_runs/1/edit
  def edit
  end

  # POST /test_suite_runs
  # POST /test_suite_runs.json
  def create
    @test_suite_run = TestSuiteRun.new(test_suite_run_params)

    respond_to do |format|
      if @test_suite_run.save
        format.html { redirect_to @test_suite_run, notice: 'Test suite run was successfully created.' }
        format.json { render :show, status: :created, location: @test_suite_run }
      else
        format.html { render :new }
        format.json { render json: @test_suite_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_suite_runs/1
  # PATCH/PUT /test_suite_runs/1.json
  def update
    respond_to do |format|
      if @test_suite_run.update(test_suite_run_params)
        format.html { redirect_to @test_suite_run, notice: 'Test suite run was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_suite_run }
      else
        format.html { render :edit }
        format.json { render json: @test_suite_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_suite_runs/1
  # DELETE /test_suite_runs/1.json
  def destroy
    @test_suite_run.destroy
    respond_to do |format|
      format.html { redirect_to test_suite_runs_url, notice: 'Test suite run was successfully destroyed.' }
      format.json { head :no_content }
    end
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
