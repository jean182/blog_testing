Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'welcome/index'
  get 'welcome/about', to: 'welcome#about', as: 'about'
  get 'welcome/dashboard', to: 'welcome#dashboard', as: 'dashboard'

  resources :categories

  resources :posts do
    resources :comments
  end

  resources :users

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
