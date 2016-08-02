require 'test_helper'

class TestSuiteRunsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @test_suite_run = test_suite_runs(:one)
  end

  test "should get index" do
    get test_suite_runs_url
    assert_response :success
  end

  test "should get new" do
    get new_test_suite_run_url
    assert_response :success
  end

  test "should create test_suite_run" do
    assert_difference('TestSuiteRun.count') do
      post test_suite_runs_url, params: { test_suite_run: {  } }
    end

    assert_redirected_to test_suite_run_url(TestSuiteRun.last)
  end

  test "should show test_suite_run" do
    get test_suite_run_url(@test_suite_run)
    assert_response :success
  end

  test "should get edit" do
    get edit_test_suite_run_url(@test_suite_run)
    assert_response :success
  end

  test "should update test_suite_run" do
    patch test_suite_run_url(@test_suite_run), params: { test_suite_run: {  } }
    assert_redirected_to test_suite_run_url(@test_suite_run)
  end

  test "should destroy test_suite_run" do
    assert_difference('TestSuiteRun.count', -1) do
      delete test_suite_run_url(@test_suite_run)
    end

    assert_redirected_to test_suite_runs_url
  end
end
