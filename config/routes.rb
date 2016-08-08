Rails.application.routes.draw do
  resources :users, only: [:create, :new]
  resource :session

  root :to => 'users#new'
end
