
Rails.application.routes.draw do
  #get 'errors/file_not_found'

  #get 'errors/unprocessable'

  #get 'errors/internal_server_error'

  resources :conversations  
  resources :messages
  
  
  resources :offers

  root 'communities#show'

  get '/offers/:id/rejected', :to => 'offers#rejected', as: :offer_rejected
  get '/offers/:id/accepted', :to => 'offers#accepted', as: :offer_accepted
  get '/offers/:id/confirm', :to => 'offers#confirm', as: :offer_confirm

  get '/auth/:provider/callback' => 'users#venmo'
  get '/auth/venmo', as: 'venmo_login'


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


  #match '/404', to: 'errors#file_not_found', via: :all
  #match '/422', to: 'errors#unprocessable', via: :all
  #match '/500', to: 'errors#internal_server_error', via: :all

end
