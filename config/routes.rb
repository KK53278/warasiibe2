Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
   devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  root to: "homes#top"
  get 'homes/about' => 'homes#about'

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :products, only: [:index, :show]
  end


  namespace :public do
    resources :customers, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

    resources :products, only: [:index, :show, :create, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    resources :notifications, only: [:index]

    post 'reserve/complete' => 'reserve#complete'
    post 'reserve/confirm' => 'reserve#confirm'# 確認画面
    post 'reserve/back' => 'reserve#back'# 確認画面から「入力画面に戻る」をクリックしたとき
    resources :reserve, only: [:new]


   get "search" => "searches#search"
 end


end
