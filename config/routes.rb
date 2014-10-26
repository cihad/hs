Rails.application.routes.draw do
  root "nodes#index"

  resources :nodes

  namespace :administration do
    get "/" => "base#index"
    resources :nodes, only: [:index, :update]
  end

end
