Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  get 'users/show'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "blogs#index"
  get "blog/about" => "blogs#about"
  get "search_tag" => "blogs#search_tag"
  get "search_place" => "blogs#search_place"
  get "search" => "searches#search"
  
  resources :blogs do
    resource :favorites, only: [:create, :destroy]
    resources :blog_comments,only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  
  
  
  resources :places, only: [:index, :create, :edit, :update]

  

end
