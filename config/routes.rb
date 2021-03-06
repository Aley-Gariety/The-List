ThelistIo::Application.routes.draw do

  root :to => "posts#index"

  mount API => 'api/'

  match 'guidelines' => 'pages#guidelines'

  match 'docs' => 'pages#docs'

  match 'stats' => 'pages#stats'

  match 'blog' => 'pages#blog'

  match 'blog/downtime' => 'pages#blog2'

  match 'blog/api-status' => 'pages#blog1'

  match 'blog/v2' => 'pages#blog3'

  match 'user-levels' => 'pages#levels'

  match 'user/:username' => 'users#user'

  match 'applicants' => "requests#index"

  get "suggestions" => "suggestions#index"

  get "suggestions/new" => "suggestions#new"

  get "sessions/new"

  get 'posts/recent' => 'posts#recent', :as => "recent"

  get 'posts/top' => 'posts#top', :as => "top"

  get "signout" => "sessions#destroy", :as => "signout"

  get "signin" => "sessions#new", :as => "signin"

  get "gift" => "users#new", :as => "gift"

  get "redeem/:auth_token" => "users#update"

  get "apply" => "requests#new", :as => "apply"

  put "vote", :to => "vote#vote", as: :vote

  resources :users

  resources :sessions

  resources :posts do
    get 'page-:page', :action => :index, :on => :collection
    get 'fetch-title', :action => :fetch_title, :on => :collection
    get 'recent/page-:page', :action => :recent, :on => :collection
  end

  resources :comments

  resources :password_resets

  resources :requests

  resources :suggestions do
      get 'page-:page', :action => :index, :on => :collection
      get 'recent/page-:page', :action => :recent, :on => :collection
  end

end
