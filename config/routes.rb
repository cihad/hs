Rails.application.routes.draw do
  resources :tags, only: :show

  root "nodes#index"

  resources :nodes
  resources :images, only: :show

  namespace :administration do
    get "/" => "base#index"
    resources :nodes, only: [:index, :update]
  end

end
