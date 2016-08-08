Rails.application.routes.draw do
  resources :users, only: [:create, :new, :index, :show]
  resource :session

  root :to => 'users#index'
end
