Rails.application.routes.draw do

  devise_for :admin,skip:[:registrations, :passwords], controllers:{
    sessions:"admin/sessions"
  }

  devise_for :users, skip:[:passwords], controllers:{
    registrations:"public/registrations",
    sessions:"public/sessions"
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_scope :admin do
    get 'admin/sign_out' => 'devise/sessions#destroy'
  end

  get 'top' =>'public/homes#top'
  root to:"public/homes#top"

  namespace :public do
    # userマイページ、編集画面、退会確認画面(unsubscribe)
    get '/users/my_page' =>'users#show'
    get '/users/information/edit' =>'users#edit'
    patch '/users/information' =>'users#update'
    get '/users/unsubscribe' =>'users#unsubscribe'
    patch '/users/withdraw' =>'users#withdraw'
    resources:users,only:[:index]
    resources:to_do_posts,only:[:new, :create, :index, :show, :edit, :update, :destroy] do
      resources:lists, only:[:new, :create, :edit, :update, :destroy]
      resources:post_comments, only:[:create, :destroy]
      resource:favorites, only:[:create, :destroy]
    end
    get "search" => "searches#search"
    get 'searches/index'

  end

  namespace :admin do
    root to:"homes#top"
    get 'users/:user_id/to_do_posts' => 'to_do_posts#index', as:'user_to_do_posts'
    resources:users, only:[:show, :edit, :update]
    resources:to_do_posts, only:[:index, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
