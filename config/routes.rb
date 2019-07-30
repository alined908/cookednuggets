Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :matches, module: 'matches' do
      resource :composition, :only => [:create]
      resource :general, :only => [:create]
      resource :fight, :only => [:create]
    end
  end

  scope module: 'forums' do
    resources :forum_threads, :path => 'forums/th', :as => 'threads' do
      resources :forum_posts, :path => 'p', :as => 'posts'
    end
    resources :forum_posts, :path => 'forums/p', :as => 'posts' do
      resources :forum_posts, :path => 'p', :as => 'posts'
    end
    resources :officials, :path => 'matches', :as => 'matches', :only => [] do
      resources :forum_posts, :path => 'p', :as => 'posts'
    end
    resources :news, :path => 'news', :as => 'news', :only => [] do
      resources :forum_posts, :path => 'p', :as => 'posts'
    end
  end
  resources :news, :path => 'news', :as => 'news'

  scope module: 'officials' do
    resources :events do
      resources :sections, :path => 's', :except => [:index]
    end
    resources :rankings
    resources :officials, :path => 'matches', :as => 'matches'
    resources :teams
    resources :players
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#index'
end
