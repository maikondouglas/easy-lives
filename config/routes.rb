Rails.application.routes.draw do
  root to: 'lives#index'

  devise_for :users
  
  resources :lives
end
