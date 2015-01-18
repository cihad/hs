Rails.application.routes.draw do

  default_url_options host: Rails.application.secrets.host

  get 'sitemap/sitemap'

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :tags, only: :show

  root "nodes#index"

  resources :nodes do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  resources :comments, only: :show

  resources :images, only: [:show, :edit, :update]

  namespace :administration do
    get "/" => "base#index"
    resources :nodes, only: [:index, :update, :destroy]
    resources :users, only: [:index, :edit, :update]
  end

end
