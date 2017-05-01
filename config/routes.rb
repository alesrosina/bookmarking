Rails.application.routes.draw do
  root to: 'bookmarks#index'

  resources :bookmarks, except: [:show]
  resources :search, only: [:index]
end
