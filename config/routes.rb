VagrantCook::Application.routes.draw do

  resources :app_configurations

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

  resources :bentoboxes, only: [:index, :show] do
    member do
      get 'run_list', as: 'run_list', action: 'run_list'
      get 'json_config', as: 'json_config', action: 'json_config'
    end
  end
  resources :ingredients
  resources :categories, except: [:show]
  resources :vagrantboxes
  resources :additional_configurations, except: [:show]

  resources :users, only: [:show, :edit, :update, :destroy] do
    member do
      get 'download_key', as: 'download_key', action: 'download_key'
    end

    resources :bentoboxes do
      collection do
        get 'update', as: 'update', to: "updates#index"
      end
    end



  end

  match 'chef/status' => 'chef#status', as: 'chef_server_status', via: :get
  match 'chef/client_status/:id' => 'chef#client_status', as: 'chef_client_status', via: :get

  match 'download_validation_key' => 'application#download_validation_key', as: 'download_validation_key', via: :get


  namespace :admin do
    post 'load_validation_key', to: "admin#load_validation_key"
    post 'update', to: "admin#update_app_configuration"
    root :to => 'admin#index'
  end

  root :to => 'welcome#index'
end
