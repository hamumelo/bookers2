Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get '/home/about' => 'homes#about'
  resources :books
  resources :users, only: [:new, :index, :show, :edit, :update]
  # resources :postss, only: [:new, :create]

  delete 'books/:id' => 'books#destroy', as: 'destroy_book'
  
end