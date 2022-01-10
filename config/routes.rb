Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :themes, only: [:index, :show]
      post "/count/addSearch", to: "count#add_search"
      post "/count/addEnter", to: "count#add_enter"
      post "/count/addFavorite", to: "count#add_favorite"
      post "/count/removeFavorite", to: "count#remove_favorite"
      resources :hots, only: [:index]
      namespace :user do
        post "/favorites", to: "favorites#index"
        patch "/favorite/update", to: "favorites#update"
      end

      get "/local_item/:id", to: "local_item#show"
      post "/local_item/:id/comment", to: "local_item#create_comment"

      devise_for :users,
        controllers: {
          sessions: 'sessions',
          registrations: 'registrations',
          passwords: 'passwords'
        }
    end
  end
end
