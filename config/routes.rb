# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'bookmarks#index'

  resources :bookmarks, except: [:show]
  resources :search, only: [:index]
  get 'tags/:tag_name', to: 'bookmarks#index', as: :tags
end
