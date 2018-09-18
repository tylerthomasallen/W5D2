Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  
  resources :links
  
  resources :posts, except: [:index, :new]
  
  resources :subs, except: :destroy do
    resources :posts, only: :new
  end
  
  
end
