class TestCaseRunsController < ApplicationController
  before_action :set_test_case_run, only: [:show, :edit, :update, :destroy]

  # GET /test_case_runs
  # GET /test_case_runs.json
  def index
    @test_case_runs = TestCaseRun.all
  end

  # GET /test_case_runs/1
  # GET /test_case_runs/1.json
  def show
  end

  # GET /test_case_runs/new
  def new
    @test_case_run = TestCaseRun.new
  end

  # GET /test_case_runs/1/edit
  def edit
  end

  # POST /test_case_runs
  # POST /test_case_runs.json
  def create
    @test_case_run = TestCaseRun.new(test_case_run_params)

    respond_to do |format|
      if @test_case_run.save
        format.html { redirect_to @test_case_run, notice: 'Test case run was successfully created.' }
        format.json { render :show, status: :created, location: @test_case_run }
      else
        format.html { render :new }
        format.json { render json: @test_case_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_case_runs/1
  # PATCH/PUT /test_case_runs/1.json
  def update
    respond_to do |format|
      if @test_case_run.update(test_case_run_params)
        format.html { redirect_to @test_case_run, notice: 'Test case run was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_case_run }
      else
        format.html { render :edit }
        format.json { render json: @test_case_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_case_runs/1
  # DELETE /test_case_runs/1.json
  def destroy
    @test_case_run.destroy
    respond_to do |format|
      format.html { redirect_to test_case_runs_url, notice: 'Test case run was successfully destroyed.' }
      format.json { head :no_content }
    end
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
