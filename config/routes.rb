Rails.application.routes.draw do
  root to: 'posts#index'
  resources :posts
  devise_for :users, :controllers => { :registrations => 'registrations' }
  resources :users, only: [:index, :show]
end
