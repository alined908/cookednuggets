Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  scope module: 'users' do
    resources :users, :path => 'u', :only => [:index, :show]
  end

  def post_resource
    resources :forum_posts, :path => 'p', :as => 'posts'
  end

  scope module: 'forums' do
    resources :forum_threads, :path => 'forums', :as => 'threads' do
      post_resource
    end
    resources :forum_posts, :path => 'forums/p', :as => 'posts', :only => [] do
      member do
        post 'vote'
      end
      post_resource
    end
    resources :officials, :path => 'matches', :as => 'matches', :only => [] do
      post_resource
    end
    resources :news, :path => 'news', :as => 'news', :only => [] do
      post_resource
    end
  end

  scope module: 'news' do
    resources :news, :path => 'news', :as => 'news'
  end

  scope module: 'officials' do
    resources :events do
      resources :sections, :path => 's', :except => [:index]
    end
    resources :rankings, :only => [:index]
    resources :officials, :path => 'matches', :as => 'matches', :except => [:edit]
    resources :teams
    resources :players
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#index'
end
