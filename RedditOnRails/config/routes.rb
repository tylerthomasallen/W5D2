Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  
  resources :links
  
  resources :posts, except: [:index]
  
  resources :subs, except: :destroy
  
  
end
