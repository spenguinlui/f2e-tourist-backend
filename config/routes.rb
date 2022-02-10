Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # for custom user routes
  devise_for :users, only: []

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :themes, only: [:index, :show]
      
      post "/count/addSearch", to: "count#add_search"
      post "/count/addEnter", to: "count#add_enter"
      post "/count/addFavorite", to: "count#add_favorite"
      post "/count/removeFavorite", to: "count#remove_favorite"

      resources :hots, only: [:index]

      namespace :user do
        post "/sign_in", to: "sessions#sign_in"
        delete "/sign_out", to: "sessions#sign_out"
        post "/sign_up", to: "registrations#sign_up"
        post "/forget_password", to: "passwords#create"
        post "/edit_password", to: "passwords#edit"
        post "/check", to: "sessions#check"
        post "/favorites", to: "favorites#index"
        patch "/favorite/update", to: "favorites#update"
        post "/sign_in_by_google", to: "sessions#google_oauth2"
        post "/sign_in_by_facebook", to: "sessions#facebook"
      end
      
      get "/local_item/:id", to: "local_item#show"
      post "/local_item/:id/comment", to: "local_item#create_comment"
      post "/local_items/average_scores", to: "local_item#average_scores"
      
      namespace :supplier do
        post "/check", to: "sessions#check"
        post "/sign_in", to: "sessions#sign_in"
        delete "/sign_out", to: "sessions#sign_out"
      end

      namespace :admin do
        post "/check", to: "sessions#check"
        post "/sign_in", to: "sessions#sign_in"
        post "/sign_out", to: "sessions#sign_out"
        resources :themes
        resources :users
        post "userslist", to: "users#index"
        post "setting", to: "setting#index"
        patch "setting/:id", to: "setting#update"
        post "supplierlist", to: "supplier#index"
      end
    end
  end
end
