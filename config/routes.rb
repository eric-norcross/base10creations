Martinfurniture::Application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"

  root to: 'pages#home'

  # Ajax Routes
  post '/collections/products/:id'        => 'collections#products'
  post '/collections/finishes/:id'        => 'collections#finishes'
  post '/collections/skus_by_finish/:id'  => 'collections#skus_by_finish'

  # Admins/Users Routes
  if Rails.env.production?
    devise_for :admins, :skip => [:registrations]
  else
    devise_for :admins
  end

  as :admin do
    get 'admins/edit'          => 'devise/registrations#edit',      as: :edit_admin_registration
    put 'admins'               => 'devise/registrations#update',    as: :admin_registration


    get 'admin'                => 'admins#dashboard'
    get 'admin/home'           => 'admins#dashboard'
    get 'admin/dashboard'      => 'admins#dashboard',               as: :admin_dashboard
  
    get 'admin/brands'         => 'brands#admin_index',             as: :admin_brands
    get 'admin/categories'     => 'categories#admin_index',         as: :admin_categories
    get 'admin/collections'    => 'collections#admin_index',        as: :admin_collections
    get 'admin/compilations'   => 'compilations#admin_index',       as: :admin_compilations
    get 'admin/components'     => 'components#admin_index',         as: :admin_components
    get 'admin/finishes'       => 'finishes#admin_index',           as: :admin_finishes
    get 'admin/locations'      => 'locations#admin_index',          as: :admin_locations
    get 'admin/dealers'        => 'locations#admin_index'
    get 'admin/retailers'      => 'locations#admin_index'
    get 'admin/pages'          => 'pages#admin_index',              as: :admin_pages
    get 'admin/products'       => 'products#admin_index',           as: :admin_products
    get 'admin/sections'       => 'sections#admin_index',           as: :admin_sections
    get 'admin/skins'          => 'skins#admin_index',              as: :admin_skins
    get 'admin/styles'         => 'styles#admin_index',             as: :admin_styles

    #For data sanitization
    get 'admin/dimensions'     => 'dimensions#admin_index',         as: :admin_dimensions
    get 'admin/features'       => 'products#admin_features_index',  as: :admin_products_features
  end

  devise_for :users

  # General Routes
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

  resources :admins
  # resources :users
  resources :locations
  resources :messages
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
  resources :dimensions

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
