Rails.application.routes.draw do
  devise_for :users

  resources :home, only: [:index]

  root 'home#index'

  resources :blogs, path: '' do
    resources :posts, path: ''
  end
end
