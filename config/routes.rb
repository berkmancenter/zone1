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
  resources :roles, :as => :role
  resources :groups

  match 'upload' => 'stored_files#new', :as => :upload
  match 'search' => 'search#index', :as => :search  #, :via => :post
end
