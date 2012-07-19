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


  match 'chef/create_client/:user_id' => 'chef#create_client', as: 'chef_create_client', via: :get
  match 'chef/delete_client/:user_id' => 'chef#delete_client', as: 'chef_delete_client', via: :get
  match 'chef/get_client/:user_id' => 'chef#get_client', as: 'chef_get_client', via: :get


  root :to => 'welcome#index'
end
