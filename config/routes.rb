Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    root to: "crypted_notes#index", as: :authenticated_root

    resources :crypted_notes do
      resources :permitted_contacts do
        get "verify"
        patch "verify_update", to: "verify_update"
      end
    end
  end
  root to: redirect("/users/sign_in")
end
