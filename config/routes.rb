
Rails.application.routes.draw do
  resources :offers

  root 'communities#show'

  get '/offers/:id/rejected', :to => 'offers#rejected', as: :offer_rejected
  get '/offers/:id/accepted', :to => 'offers#accepted', as: :offer_accepted
  get '/offers/:id/confirm', :to => 'offers#confirm', as: :offer_confirm

  get '/auth/:provider/callback' => 'users#venmo'
  get '/auth/venmo', as: 'venmo_login'


  resources :messages do
    member do
      post :new
    end
  end
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
    collection do
      get :trashbin
      post :empty_trash
    end
  end

  get '/communities/search', as: :search
  get '/communities/info', as: :info
  post '/communities/search' => 'communities#set', as: :set

  post '/items' => 'items#search'

  resources :communities do 
    resources :items
  end

  resources :users do
    resources :offers, only: [:index]
    resources :items do 
      resources :offers, only: [:new]
    end
  end

  get '/users/:id/offers/sent' => 'offers#sent', as: :offers_sent
  get '/users/:id/offers/received' => 'offers#received', as: :offers_received

  delete '/users/:user_id/items/:id', to: 'items#destroy', as: :delete_item
  patch '/users/:id' => 'users#update'
  get '/signup' => 'users#new'

  get '/logout', to: 'sessions#destroy', as: :logout
  get '/login', to: 'sessions#new', as: :login
  post '/login' => 'sessions#create'

  get '/about' => 'static_pages#about', as: :about

end
