Zone1::Application.routes.draw do

  devise_for :users

  root :to => "home#index"

  resources :bulk_edits, :only => [:new, :create]

  resources :stored_files, :as => :stored_file do
    collection do
      post :download_set
      post :bulk_edit
      delete :bulk_destroy
    end
    member do
      get :thumbnail
      post :toggle_method
      get :download
    end
    resources :comments
  end
  
  resources :groups, :only => [:new, :create, :edit, :update, :destroy, :index]

  match 'memberships/:id/:membership_code/accept' => 'memberships#accept', :as => :accept_membership

  namespace :admin, :as => :admin do
    resources :users, :only => [:edit, :update, :index]
    resources :flags, :only => [:show, :create, :edit, :update, :destroy, :index]
    resources :roles, :only => [:show, :create, :edit, :update, :destroy, :index]
    resources :rights, :only => [:show, :create, :edit, :update, :destroy, :index]
    resources :mime_type_categories, :only => [:show, :create, :edit, :update, :destroy, :index]
    resources :mime_types, :only => [:show, :create, :edit, :update, :destroy, :index]
  end
  match '/admin' => 'admin::Base#index'
  match '/admin/update' => 'admin::Base#update'

  match 'upload' => 'stored_files#new', :as => :upload
  match 'search' => 'search#index', :as => :search

  resources :sftp_users, :only => :create
  mount Resque::Server, :at => '/resque'

end
