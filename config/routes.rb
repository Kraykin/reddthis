Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'posts#index'
  resources :posts
  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  resources :users, only: [:index, :show]
end
