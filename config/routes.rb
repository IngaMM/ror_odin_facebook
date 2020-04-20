Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users
  resources :friendrequests, only: [:create]
  resources :friendships, only: [:create, :destroy]
  resources :posts
  resources :photos
  resources :likes, only: [:create]
  resources :comments, only: [:new, :create]
  root 'static_pages#home'
  get  'static_pages/home'
end
