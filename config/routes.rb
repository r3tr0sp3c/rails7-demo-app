Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "accounts#index"

  resources :accounts do
    member do
      get :vat_search
    end
  end
end
