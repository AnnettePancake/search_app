Rails.application.routes.draw do
  resources :search, only: :index do
    post :find_dimensions, on: :collection
  end

  root to: 'search#index'
end
