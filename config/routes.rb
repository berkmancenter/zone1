Zone1::Application.routes.draw do

  devise_for :users

  root :to => "home#index"

  put 'temp_admin_toggle/:id', to: 'application#temp_admin_toggle_for_testing', as: :toggle_admin

  resources :bulk_edits, :only => [:new, :create] do
    collection do 
      post :csv_edit
    end
  end

  resources :stored_files, :as => :stored_file do
    collection do
      post :download_set
      post :export_to_repo
      post :export_refresh_collections
      post :bulk_edit
      delete :bulk_destroy
    end
    member do
      get :thumbnail
      get :download
    end
    resources :comments
  end

  resources :groups, :only => [:new, :create, :edit, :update, :destroy, :index]
  resources :sftp_users, :only => :create

  match 'upload' => 'stored_files#new', :as => :upload
  match 'search' => 'search#index', :as => :search
  match 'search/tags' => 'search#tags'

  match 'documentation/user' => 'application#user_docs'
  match 'documentation/admin' => 'application#admin_docs'

  match 'memberships/:membership_code/accept' => 'memberships#accept', :as => :accept_membership
  match 'memberships/:group_id/group_accept' => 'memberships#group_accept', :as => :group_accept
  match 'memberships/:group_id/group_decline' => 'memberships#group_decline', :as => :group_decline
  match 'memberships/:id/resend_invite' => 'memberships#resend_invite', :as => :resend_group_invite

  namespace :admin do
    resources :users, :only => [:edit, :update, :index]
    resources :flags, :only => [:show, :create, :edit, :update, :destroy, :index]
    resources :roles, :only => [:show, :create, :edit, :update, :destroy, :index]
    resources :rights, :only => [:show, :create, :edit, :update, :destroy, :index]
    resources :mime_types
    resources :mime_type_categories, :only => [:show, :create, :edit, :update, :destroy, :index]
  end
  match '/admin' => 'admin::Base#index'
  match '/admin/update' => 'admin::Base#update'

  mount Resque::Server, :at => '/resque'
end
