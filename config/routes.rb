Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "blogs#index"
  resources :blogs do
    resource :favorites, only: [:create, :destroy]
    resources :blog_comments,only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update]
  
end
