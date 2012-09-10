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
    member do
      get 'download_key', as: 'download_key', action: 'download_key'
    end

    resources :bentoboxes
  end

  match 'chef/status' => 'chef#status', as: 'chef_server_status', via: :get
  match 'chef/client_status/:id' => 'chef#client_status', as: 'chef_client_status', via: :get

  root :to => 'welcome#index'
end
