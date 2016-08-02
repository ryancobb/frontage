json.array!(@test_case_runs) do |test_case_run|
  json.extract! test_case_run, :id
  json.url test_case_run_url(test_case_run, format: :json)
end
