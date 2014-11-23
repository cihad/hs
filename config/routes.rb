Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :tags, only: :show

  root "nodes#index"

  resources :nodes
  resources :images, only: :show

  namespace :administration do
    get "/" => "base#index"
    resources :nodes, only: [:index, :update]
  end

end
