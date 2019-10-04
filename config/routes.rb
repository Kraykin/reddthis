Rails.application.routes.draw do
  root to: 'posts#index'

  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :registrations => 'users/registrations' }

  post '/posts/:post_id/comments', to: 'comments#create', as: :post_comments
  resources :users, :posts, :comments do
    member do
      put 'upvote'
      put 'downvote'
    end
  end
end
