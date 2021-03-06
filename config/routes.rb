Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  resources :users, only: [:show] do
    collection do
      get 'privacy', to: 'users/privacy'
      get 'exhibit', to: 'users/exhibit'
    end
    get :favorites, on: :collection
  end

  root to:'items#index'
  resources :addresses, only: [:new]

  resources :items do
    collection do
      match 'search', to: 'items#search', via: [:get, :post]
      get 'price_range', defaults: { format: 'json' }
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
    end

    resources :purchase do
      collection do
        get 'index', to: 'purchase#index'
        post 'pay', to: 'purchase#pay'
        get 'done', to: 'purchase#done'
      end
    end

    resources :comments, only: [:create, :show, :edit, :destroy]
    collection do
      get 'search'
    end

    resource :favorites, only: [:create, :destroy]
  end

  resources :cards, only: [:new, :show] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
      get 'new', to: 'cards#new'
    end
  end

  resources :categories, only: [:index]

end
