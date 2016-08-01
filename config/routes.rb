Rails.application.routes.draw do
  devise_for :users
  mount ActionCable.server => '/cable'
  resources :home, only: [:index]

  root 'home#index'
  resources :blogs, only: [:index, :new, :create] do
    resources :posts, only: [:index, :new, :create] do
      resources :comments, only: [:create]
    end
  end
  resources :blogs, path: '' do
    resources :posts, path: ''
  end
end
