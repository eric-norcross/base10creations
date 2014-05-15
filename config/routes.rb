Base10cms::Application.routes.draw do  
  root to: 'pages#home'

  # Ajax Routes


  # Admin Routes
  if Rails.env.production?
    devise_for :admins, :skip => [:registrations]
  else
    devise_for :admins
  end

  as :admin do
    mount Ckeditor::Engine => "/ckeditor"

    get 'admins'               => 'admins#dashboard'
    get 'admins/home'          => 'admins#dashboard'
    get 'admins/dashboard'     => 'admins#dashboard'

    get 'admin'                => 'admins#dashboard'
    get 'admin/home'           => 'admins#dashboard'
    get 'admin/dashboard'      => 'admins#dashboard',                 as: :admin_dashboard
  end
  
  # Error Pages
  %w( 404 422 500 ).each do |code|
    get code, :to => "errors#show", :code => code
  end

  # Backward compatible routes for previous website
  
  # Search Routes

  # General Routes
  resources :carousels
  resources :figures
  resources :images
  resources :pages
  resources :skins

  # Catch all for anything else
  match '*path' => redirect('/') unless Rails.env.development?

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
