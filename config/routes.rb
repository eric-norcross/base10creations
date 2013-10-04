Martinfurniture::Application.routes.draw do  
  mount Ckeditor::Engine => "/ckeditor"

  root to: 'pages#home'

  # Ajax Routes
  post '/collections/products/:id'        => 'collections#products'
  post '/collections/finishes/:id'        => 'collections#finishes'
  post '/collections/skus_by_finish/:id'  => 'collections#skus_by_finish'

  # Admin Routes
  if Rails.env.production?
    devise_for :admins, :skip => [:registrations]
  else
    devise_for :admins
  end

  as :admin do
    # For production because of skip registrations
    get 'admins/edit'          => 'devise/registrations#edit',        as: :edit_admin_registration
    put 'admins'               => 'devise/registrations#update',      as: :admin_registration

    get 'admin'                => 'admins#dashboard'
    get 'admin/home'           => 'admins#dashboard'
    get 'admin/dashboard'      => 'admins#dashboard',                 as: :admin_dashboard

    get 'admin/admins'         => 'admins#index',                     as: :manage_admins
    delete 'admin/admins/:id'  => 'admins#destroy',                   as: :destroy_admin

    # get 'admin/users'          => 'users#index',                    as: :manage_users 

    get 'admin/list'           => 'editors#index',                    as: :manage_editors
    get 'admin/editors/new'    => 'editors#new',                      as: :new_editor
    post 'admin/editors'       => 'editors#create',                   as: :editors
    delete 'admin/editors/:id' => 'editors#destroy',                  as: :destroy_editor

    #For data sanitization
    get 'admin/dimensions'     => 'dimensions#manage',                as: :manage_dimensions
    get 'admin/features'       => 'products#manage_product_features', as: :manage_products_features
    
    # Update Search Relations
    get 'searchs/update'       => 'searches#update',                  as: :update_searches
  end


  # Editor Routes
  devise_for :editors, :skip => [:registrations],  :controllers => { :registrations => "editors" }

  get "/sign_in"  => redirect("/editors/sign_in")
  get "/login"    => redirect("/editors/sign_in")
  get "/log_in"   => redirect("/editors/sign_in")


  as :editor do
    # For production because of skip registrations
    # get 'editors/edit'          => 'devise/registrations#edit',      as: :edit_editor_registration
    # put 'editors'               => 'devise/registrations#update',    as: :editor_registration

    get 'editor'                => 'editors#dashboard'
    get 'editor/home'           => 'editors#dashboard'
    get 'editor/dashboard'      => 'editors#dashboard',             as: :editor_dashboard
  end

  as :admin || :editor do
    get 'brands/manage'         => 'brands#manage',           as: :manage_brands
    get 'categories/manage'     => 'categories#manage',       as: :manage_categories
    get 'collections/manage'    => 'collections#manage',      as: :manage_collections
    get 'compilations/manage'   => 'compilations#manage',     as: :manage_compilations
    get 'components/manage'     => 'components#manage',       as: :manage_components
    get 'finishes/manage'       => 'finishes#manage',         as: :manage_finishes
    get 'pages/manage'          => 'pages#manage',            as: :manage_pages
    get 'products/manage'       => 'products#manage',         as: :manage_products
    get 'sections/manage'       => 'sections#manage',         as: :manage_sections
    get 'skins/manage'          => 'skins#manage',            as: :manage_skins
    get 'styles/manage'         => 'styles#manage',           as: :manage_styles
    get 'videos/manage'         => 'videos#manage',           as: :manage_videos

    get 'editor/dealers'        => 'locations#manage'
    get 'editor/retailers'      => 'locations#manage'
    get 'editor/locations'      => 'locations#manage',        as: :manage_locations
  end


  # devise_for :users

  # Error Pages
  %w( 404 422 500 ).each do |code|
    get code, :to => "errors#show", :code => code
  end

  # Search Routes


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
  
  resources :brands
  resources :carousels
  resources :categories
  resources :collections
  resources :collection_styles
  resources :components
  resources :compilations
  resources :dimensions
  resources :figures
  resources :images
  resources :locations
  resources :messages
  resources :pages
  resources :products
  resources :product_components
  resources :searches
  resources :sections
  resources :skins
  resources :skus
  resources :styles
  resources :videos

  
  

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
