Rails.application.routes.draw do
  resources :crypted_notes
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  authenticate :user do
    root to: "crypted_notes#index", as: :authenticated_root
  end
  root to: redirect("/users/sign_in")
end
