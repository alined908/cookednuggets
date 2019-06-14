Rails.application.routes.draw do
  devise_for :users

  scope module: 'forums' do
    resources :forum_threads, :path => 'forums/threads' do
      resources :forum_posts, :path => 'posts'
    end
  end

  resources :users do
    resources :matches, module: 'matches' do
      resource :composition, :only => [:create]
      resource :general, :only => [:create]
      resource :fight, :only => [:create]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#index'
end
