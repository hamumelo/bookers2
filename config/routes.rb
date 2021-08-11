Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get '/homes/about' => 'homes#about'
  resources :books
  resources :users, only: [:new, :index, :show, :edit, :update]
  delete 'books/:id' => 'books#destroy', as: 'destroy_book'
  
end