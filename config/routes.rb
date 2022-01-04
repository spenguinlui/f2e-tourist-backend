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

      devise_for :users,
        defaults: { format: :json },
        controllers: {
          sessions: 'sessions',
          registrations: 'registrations',
          passwords: 'passwords'
        }
    end
  end
end
