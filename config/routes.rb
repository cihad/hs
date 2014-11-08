Rails.application.routes.draw do
  resources :tags, only: :show

  root "nodes#index"

  resources :nodes

  namespace :administration do
    get "/" => "base#index"
    resources :nodes, only: [:index, :update]
  end

end
