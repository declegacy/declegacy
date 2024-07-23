Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    root to: "crypted_notes#index", as: :authenticated_root

    resources :crypted_notes do
      resources :permitted_contacts do
        get "verify"
        patch "verify_update", to: "verify_update"
        post "request_access", to: "request_access"
        post "reject_access", to: "reject_access"
        get "reject_access"
      end
    end
  end

  get "/crypted_notes/*whatever", to: redirect("/users/sign_in")
  root to: redirect("/users/sign_in")
end
