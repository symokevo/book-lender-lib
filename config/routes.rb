Rails.application.routes.draw do
  root "books#index"

  resources :books do
    member do
      patch :borrow
      patch :return
    end
  end

  resources :borrowings


  get "up" => "rails/health#show", as: :rails_health_check
end
