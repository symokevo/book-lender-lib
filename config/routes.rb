Rails.application.routes.draw do
  root "books#index"

  resources :books do
    member do
      post :borrow
      post :return
    end
  end

  resources :borrowings


  get "up" => "rails/health#show", as: :rails_health_check
end
