Rails.application.routes.draw do
  devise_for :users

  resources :home, only: [:index]

  root 'home#index'
  resources :blogs, only: [:index, :new, :create] do
    resources :posts, only: [:index, :new, :create]
  end
  resources :blogs, path: '' do
    resources :posts, path: ''
  end
end
