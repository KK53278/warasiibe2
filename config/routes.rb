Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
}

  namespace :admin do
    root to: "homes#top"
    get 'homes/about' => 'homes#about'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :products, only: [:index, :show]
  end

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
}

  scope module: :public do
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
    resources :reserve, only: [:new]
    post 'reserve/complete' => 'reserve#complete'
    post 'reserve/confirm' => 'reserve#confirm'# 確認画面
    post 'reserve/back' => 'reserve#back'# 確認画面から「入力画面に戻る」をクリックしたとき
    get "search" => "searches#search"
 end


end
