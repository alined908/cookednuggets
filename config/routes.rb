Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  resources :users

  scope module: 'forums' do
    resources :forum_threads, :path => 'forums', :as => 'threads' do
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
  scope module: 'news' do
    resources :news, :path => 'news', :as => 'news'
  end


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
