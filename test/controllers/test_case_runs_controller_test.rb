require 'test_helper'

class TestCaseRunsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @test_case_run = test_case_runs(:one)
  end

  test "should get index" do
    get test_case_runs_url
    assert_response :success
  end

  test "should get new" do
    get new_test_case_run_url
    assert_response :success
  end

  test "should create test_case_run" do
    assert_difference('TestCaseRun.count') do
      post test_case_runs_url, params: { test_case_run: {  } }
    end

    assert_redirected_to test_case_run_url(TestCaseRun.last)
  end

  test "should show test_case_run" do
    get test_case_run_url(@test_case_run)
    assert_response :success
  end

  test "should get edit" do
    get edit_test_case_run_url(@test_case_run)
    assert_response :success
  end

  test "should update test_case_run" do
    patch test_case_run_url(@test_case_run), params: { test_case_run: {  } }
    assert_redirected_to test_case_run_url(@test_case_run)
  end

  test "should destroy test_case_run" do
    assert_difference('TestCaseRun.count', -1) do
      delete test_case_run_url(@test_case_run)
    end

    assert_redirected_to test_case_runs_url
  end
end
