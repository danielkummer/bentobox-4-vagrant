VagrantCook::Application.routes.draw do

  resources :categories

  resources :ingredients do
    resources :portmappings
  end

  resources :vagrantboxes

  resources :bentoboxes

  resources :users

  root :to => 'welcome#index'


end
