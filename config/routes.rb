Zone1::Application.routes.draw do

  devise_for :users

  root :to => "home#index"

  resources :stored_files, :as => :stored_file do
    collection do
      post :download_set
    end
    member do
      post :toggle_method
      get :download
    end
    resources :comments
  end
  resources :groups

  namespace :admin, :as => :admin do
    resources :users
    resources :flags
    resources :roles
    resources :rights
  end
  match '/admin' => 'admin::Base#index'

  match 'upload' => 'stored_files#new', :as => :upload
  match 'search' => 'search#index', :as => :search
end
