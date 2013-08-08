Martinfurniture::Application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"

  resources :finishes do
    resources :images
  end

  resources :products do
    resources :skus
  end

  resources :compilations do
    resources :products do
      resources :skus
    end
  end

  resources :brands
  resources :carousels
  resources :categories
  resources :collections
  resources :collection_styles
  resources :product_components
  resources :components
  resources :compilations
  resources :figures
  resources :pages
  resources :products
  resources :sections
  resources :skins
  resources :skus
  resources :styles
  resources :images
  resources :subsections

  resources :dimensions
  
  #root :to => redirect('/pages/home'), :action => :index

  root to: 'pages#home'

  # Ajax Routes
  post '/collections/products/:id'    => 'collections#products'
  post '/collections/finishes/:id'    => 'collections#finishes'
  post '/finishes/skus/:id'           => 'finishes#skus'

  # match '*path' => redirect('/') unless Rails.env.development?

  # match '/pages/:name', :to => redirect {"/%{name}"}

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
