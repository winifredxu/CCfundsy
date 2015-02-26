Rails.application.routes.draw do

  #get 'nearby_campaigns/index'
  resources :nearby_campaigns, only: :index #use with geocoding

  resources :discussions do
    resources :comments, only: :create
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  resources :campaigns do
    resources :publishings, only: :create
    resources :comments, only: :create
  end
  
  resources :users, only: [ :new, :create ]
  resources :sessions, only: [ :new, :create ] do
    delete :destroy, on: :collection # on collection does not require an ID
    delete :destory_1, on: :member # on member will require an ID
    delete :destory_2 # will use a session ID in the route
  end

  resources :reward_levels, only: [] do
    resources :pledges, only: [ :new, :create, :index, :destroy ]
  end

  resources :pledges, only: [] do
    resources :payments, only: [:new, :create]
  end

  #API routes
  # want /api/v1/campaigns, need to use namespace
  # namespace - URL route changes, controller changes
  # scope - URL route changes, but goes to the standard controller
  namespace :api, defaults: {format: :json} do 
    namespace :v1 do
      resources :campaigns, only: [ :index, :show, :create ]
    end
  end

  root "campaigns#index"


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