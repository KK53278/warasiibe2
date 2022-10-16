Rails.application.routes.draw do

  namespace :admin do
    get 'products/index'
    get 'products/show'
  end
  namespace :public do
    get 'reserve/new'
    get 'reserve/confirm'
    get 'reserve/complete'
  end
  namespace :public do
    get 'searches/search'
  end
  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  namespace :public do
    get 'favorites/create'
    get 'favorites/destroy'
  end
  namespace :public do
    get 'products/show'
    get 'products/index'
      #配送依頼フォーム
    get 'reserve/new' # 入力画面
    post 'reserve/confirm' # 確認画面
    post 'reserve/back' # 確認画面から「入力画面に戻る」をクリックしたとき
    post 'reserve/complete' # 完了画面
  end
    get 'homes/top'
    get 'homes/about'

  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  root to: "homes#top"

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :products, only: [:index, :show]
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  namespace :public do
    resources :customers, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
   end
    resources :products do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
   end

   get "search" => "searches#search"
 end


end
