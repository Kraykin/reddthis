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
  # TODO Refactor comments and users routes
  # resources :users, only: [:index, :show]
  resources :users do
    member do
      put 'upvote',   to: 'users#upvote'
      put 'downvote', to: 'users#downvote'
    end
  end
  resources :comments do
    member do
      put 'upvote',   to: 'comments#upvote'
      put 'downvote', to: 'comments#downvote'
    end
  end
end
