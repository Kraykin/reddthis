Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: 'posts#index'
  resources :posts
  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  resources :users, only: [:index, :show]
  # TODO Refactor comments routes
  resources :comments
end
