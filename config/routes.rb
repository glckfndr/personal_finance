Rails.application.routes.draw do

  get 'reports/index'
  get 'reports/report_by_category'
  get 'reports/report_by_dates'
  get '/create_report', to: 'reports#create_report'
  root 'main#index'
  resources :operations
  resources :categories
end
