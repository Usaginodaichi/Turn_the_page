Rails.application.routes.draw do

  devise_for :admins,skip:[:registrations, :passwords], controllers:{
    sessions:"admin/sessions"
  }

  devise_for :users, skip:[:passwords], controllers:{
    registrations:"public/registrations",
    sessions:"public/sessions"
  }

  get 'top' =>'public/homes#top'
  root to:"public/homes#top"

  namespace :public do
    # userマイページ、編集画面、退会確認画面(unsubscribe)
    get '/users/my_page' =>'users#show'
    get '/users/information/edit' =>'users#edit'
    patch '/users/information' =>'users#update'
    get '/users/unsubscribe' =>'users#unsubscribe'
    patch '/users/withdraw' =>'users#withdraw'

    resources:posts, only:[:new, :index, :show, :edit, :create, :update, :destroy]
    resources:todos, only:[:new, :create, :edit, :update, :destroy]
  end

  namespace :admin do
    root to:"homes#top"
    resources:users, only:[:index, :show, :edit, :update]
    resources:posts, only:[:show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
