Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
  	resources :comments, only: [:create, :destroy]
  end

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  #いいね機能ルーティング
  post   '/like/:post_id' => 'likes#like',   as: 'like'
  delete '/like/:post_id' => 'likes#unlike', as: 'unlike'

  #チャット機能のルーティング
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]

  root 'homes#top'
end
