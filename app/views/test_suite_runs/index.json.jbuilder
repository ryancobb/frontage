json.array!(@test_suite_runs) do |test_suite_run|
  json.extract! test_suite_run, :id
  json.url test_suite_run_url(test_suite_run, format: :json)
end
