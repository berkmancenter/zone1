Zone1::Application.routes.draw do

  devise_for :users

  root :to => "home#index"

  resources :stored_files, :as => :stored_file do
    member do
      post :toggle_method
    end
  end
  resources :roles, :as => :role

  match 'upload' => 'stored_files#new', :as => :upload
  match 'search' => 'search#index', :as => :search  #, :via => :post
end
