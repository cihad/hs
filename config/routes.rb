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

  get '/nodes/new/:controller', as: :new_new_node, action: :new

  default_url_options host: Rails.application.secrets.host

  get 'sitemap/sitemap'

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :tags, only: :show

  root "nodes#index"

  resources :nodes, only: [:index, :new, :show, :destroy] do
    resources :comments, only: [:create, :edit, :update, :destroy] do
      get :authenticate, on: :member
    end
  end

  get 'nodes/new/content', to: "contents#new", as: :new_content
  resources :contents

  get 'nodes/new/product', to: "products#new", as: :new_product
  resources :products


  resources :comments, only: :show

  resources :images, only: [:show, :create, :edit, :update]

  namespace :administration do
    get "/" => "base#index"
    resources :nodes, only: [:index, :destroy]
    resources :users, only: [:index, :edit, :update]
    resources :images, only: [:index, :destroy]
  end

end
