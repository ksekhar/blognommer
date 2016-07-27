Rails.application.routes.draw do

  resources :blogs do
    resources :posts
  end

  devise_for :users

  resources :home, only: [:index]

  root 'home#index'
end
