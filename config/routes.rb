Rails.application.routes.draw do
  devise_for :users
  mount ActionCable.server => '/cable'
  resources :home, only: [:index]
  resources :users, path: 'admin/users', controller: 'admin/users'
  root 'home#index'
  resources :blogs, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :posts, only: [:new, :create, :edit, :update, :destroy] do
      member do
        put :publish
      end
      resources :comments, only: [:create]
    end
  end

  match ':blog_id', as: :blog_posts_no_prefix,
        via: :get,
        controller: :posts,
        action: :index
  match ':blog_id/:id', as: :blog_post_no_prefix,
        via: :get,
        controller: :posts,
        action: :show
  match '/', as: :blogs_no_prefix,
        via: :get,
        controller: :blogs,
        action: :index
end
