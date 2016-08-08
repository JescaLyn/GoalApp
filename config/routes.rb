Rails.application.routes.draw do
  resources :users, only: [:create, :new, :index, :show]
  resource :session
  resources :goals

  root :to => 'users#index'
end
