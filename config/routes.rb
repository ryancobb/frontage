Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :test_suites, :only => [:index, :show] do
    resources :test_cases, :only => [:show] do
      resources :test_case_runs, :only => [:index, :show]
    end
    resources :test_suite_runs, :only => [:index, :show]
  end

  resources :users, :only => [:show]
  resources :issues, :only => [:index]

  # Custom Routes
  get   "login"  => "sessions#new", :as => :login
  post  "login"  => "sessions#create"
  match "logout" => "sessions#destroy", :as => :logout, :via => [:get, :delete]

  get 'test_suites/:id/run' => "test_suites#run", :as => :run_test_suite
  get 'test_suites/:id/last_20_runs' => "test_suite_runs#last_20_runs"

  get 'profile' => "users#show", :as => :profile

  # Default Route
  root "dashboard#index"
end
