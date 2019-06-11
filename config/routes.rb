Rails.application.routes.draw do
  devise_for :users, :paths => 'users'

  resources :articles
  resources :users do
    resources :matches do
      resource :composition, :only => [:create]
      resource :general, :only => [:create]
      resource :fight, :only => [:create]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#index'
end
