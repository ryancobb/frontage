Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :test_suites do
    resources :test_suite_runs do
      resources :test_case_runs
    end
    resources :test_cases
  end

  # Custom Routes
  get   "login"  => "sessions#new", :as => :login
  post  "login"  => "sessions#create"
  match "logout" => "sessions#destroy", :as => :logout, :via => [:get, :delete]

  get 'test_suites/:id/run' => "test_suites#run", :as => :run_test_suite

  # Default Route
  root "test_suites#index"
end
