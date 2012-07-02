VagrantCook::Application.routes.draw do

  devise_for :users do
    resources :bentoboxes
  end

  resources :ingredients
  resources :categories
  resources :vagrantboxes
  resources :users

  root :to => 'welcome#index'
end
