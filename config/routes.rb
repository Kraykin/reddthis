Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: 'posts#index'
  resources :posts do
    member do
      put 'upvote',   to: 'posts#upvote'
      put 'downvote', to: 'posts#downvote'
    end
  end
  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  resources :users, only: [:index, :show]
  # TODO Refactor comments routes
  resources :comments
end
