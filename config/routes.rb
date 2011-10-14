Zone1::Application.routes.draw do
  devise_for :users

  root :to => "home#index"

  resources :stored_files, :as => :stored_file
  match 'upload' => 'upload#index', :as => :upload
  match 'search' => 'search#index', :as => :search  #, :via => :post

end
