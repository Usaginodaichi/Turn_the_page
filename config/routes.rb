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
    resources:to_do_posts,only:[:new, :create, :index, :show, :edit, :update, :destroy]do
      resources:lists, only:[:new, :create, :edit, :update, :destroy]
      resources:comments, only:[:create, :edit, :update, :destroy]
    end

  end

  namespace :admin do
    root to:"homes#top"
    resources:users, only:[:index, :show, :edit, :update]
    resources:posts, only:[:show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
