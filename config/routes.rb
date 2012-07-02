VagrantCook::Application.routes.draw do

  devise_for :users

  resources :bentoboxes, only: [:index, :show]
  resources :ingredients
  resources :categories
  resources :vagrantboxes
  resources :users do
    resources :bentoboxes, except: [:index, :show]
  end

  root :to => 'welcome#index'
end
