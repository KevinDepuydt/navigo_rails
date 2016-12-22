Rails.application.routes.draw do
  get 'home/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  resources :subscription, only: [:index, :show, :new, :create]

  post 'check_card_subscriptions' => 'card#check_card_subscriptions'
  get 'provide_card_number' => 'card#provide_card_number'
  put 'link_card_to_user' => 'card#link_card_to_user'
  get '/subscription/new/:duration' => 'subscription#new'
  post 'new_card_subscription' => 'subscription#create'
  get 'subscriptions' => 'subscription#index'
end
