Rails.application.routes.draw do

  get 'top' =>'public/homes#top'
  root to:"public/homes#top"
  namespace :public do
    get 'homes/top'
  end
  devise_for :admins,controllers:{
    sessions:"admin/sessions"
  }

  devise_for :users, skip:[:passwords], controllers:{
    registrations:"public/registrations",
    sessions:"public/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
