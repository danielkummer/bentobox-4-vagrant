VagrantCook::Application.routes.draw do

  devise_for :users, :path_names => {:sign_up => "register",
                                     :sign_in => "login",
                                     :sign_out => "logout",
                                     :settings => "settings"}

  devise_scope :user do
    get "login", :to => "devise/sessions#new"
    get "register", :to => "devise/registrations#new"
    get "settings", :to => "devise/registrations#edit"
    get "logout", :to => "devise/sessions#destroy"
  end

  resources :bentoboxes, only: [:index, :show]
  resources :ingredients
  resources :categories, except: [:show]
  resources :vagrantboxes, except: [:show]

  resources :users, only: [] do
    resources :bentoboxes
  end

  root :to => 'welcome#index'
end
