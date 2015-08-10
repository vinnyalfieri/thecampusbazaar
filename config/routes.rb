
Rails.application.routes.draw do
  resources :offers

  root 'communities#show'

  get '/offers/:id/rejected', :to => 'offers#rejected', as: :offer_rejected
  get '/offers/:id/accepted', :to => 'offers#accepted', as: :offer_accepted
  get '/offers/:id/confirm', :to => 'offers#confirm', as: :offer_confirm

  get '/auth/:provider/callback' => 'sessions#venmo', as: :venmo_login

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

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
