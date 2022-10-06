Rails.application.routes.draw do

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
    resources :customers, only: [:index, :show, :edit, :update]
    resources :products, only: [:new, :create, :index, :show]
end


end
