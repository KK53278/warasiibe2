Rails.application.routes.draw do

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
