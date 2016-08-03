Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :test_suites do
    resources :test_suite_runs do
      resources :test_case_runs
    end
    resources :test_cases
  end
end
