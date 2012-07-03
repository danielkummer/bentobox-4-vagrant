VagrantCook::Application.routes.draw do

  devise_for :users

  resources :bentoboxes, only: [:index, :show]
  resources :ingredients
  resources :categories
  resources :vagrantboxes

  resources :users, only: [:index, :show] do
    resources :bentoboxes
  end

  root :to => 'welcome#index'
end
