VagrantCook::Application.routes.draw do

  devise_for :users, :path_names => {:sign_up => "register",
                                     :sign_in => "login",
                                     :sign_out => "logout",
                                     :settings => "settings"}

  devise_scope :users do
    get "login", :to => "devise/sessions#new"
    get "register", :to => "devise/registrations#new"
    get "settings", :to => "devise/registrations#edit"
    get "logout", :to => "devise/sessions#destroy"
  end

  resources :bentoboxes, only: [:index, :show]
  resources :ingredients
  resources :categories, except: [:show]
  resources :vagrantboxes, except: [:show]
  resources :additional_configurations, except: [:show]

  resources :users, only: [:show, :edit, :update, :destroy] do
    resources :bentoboxes
    get 'download_key', as: "download_key", action: "download_key"
  end


    post '/create_client' => 'chef#create_client'

   # post "create_client/:user_id", action: "create_client"


  root :to => 'welcome#index'
end
