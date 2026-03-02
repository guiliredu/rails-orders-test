Rails.application.routes.draw do
  resources :orders do
    member do
      get :start_progress
      get :complete
    end
  end

  root "orders#index"
end
