Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'signup',  to: 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  resources :users do
    member do
      get :followings, :followers, :favorites
    end
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  
  resources :microposts do
    resources :favorites, only: [:create, :destroy]
    resources :retweets, only: [:create, :destroy]
  end
  
  resources :relationships, only: [:create, :destroy]
end