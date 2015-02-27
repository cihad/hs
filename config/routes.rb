Rails.application.routes.draw do

  get 'new_ideas/haber'
  get 'new_ideas/compare'
  get 'new_ideas/gallery'
  get 'new_ideas/poll'
  get 'new_ideas/fill_in_the_blanks'
  get 'new_ideas/earthquake'
  get 'new_ideas/currency'
  get 'new_ideas/himer'
  get 'new_ideas/tagging'
  get 'new_ideas/namaz'
  get 'new_ideas/product'
  get 'new_ideas/add'

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
    resources :nodes, only: [:index, :destroy]
    resources :users, only: [:index, :edit, :update]
    resources :images, only: [:index, :destroy]
  end

end
