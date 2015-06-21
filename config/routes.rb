# -*- coding: utf-8 -*-
ActionController::Routing::Routes.draw do |map|

  map.resources :speakers, :path_prefix => '/:customer_key'
  map.resources :members, :path_prefix => '/:customer_key'
  map.resources :people, :path_prefix => '/:customer_key'
  map.resources :ui_templates, :path_prefix => '/:customer_key'
  map.resources :configurations, :path_prefix => '/:customer_key'

  map.resources :messages, :path_prefix => '/:customer_key'
  map.resources :bookings, :path_prefix => '/:customer_key'
  map.resources :rooms, :path_prefix => '/:customer_key'


  map.resources :index
  map.connect '/index/:action/:id', :controller => 'index'
  map.connect '/index/:action/:id.xml', :controller => 'index', :action => 'occasions'

  map.resources :feedbacks, :path_prefix => '/:customer_key'
  map.resources :styles, :path_prefix => '/:customer_key'
  map.resources :graphics, :path_prefix => '/:customer_key'
  map.resources :layouts, :path_prefix => '/:customer_key'

  map.menu_page '/:customer_key/pages/menu', :controller => "pages", :action => "menu"
  map.resources :pages, :path_prefix => '/:customer_key'
  map.resources :customers, :path_prefix => '/:customer_key'
  map.userlist '/:customer_key/users/list', :controller => 'users', :action => 'list'
  map.settings '/:customer_key/settings', :controller => 'settings'
  map.logout '/:customer_key/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/:customer_key/login/:id', :controller => 'sessions', :action => 'new'
  map.register '/:customer_key/register', :controller => 'users', :action => 'create'
  map.signup '/:customer_key/signup', :controller => 'users', :action => 'new'
  map.resources :users, :path_prefix => '/:customer_key'
  map.resource :session, :path_prefix => '/:customer_key'
  map.resources :occasion_types, :path_prefix => '/:customer_key'
  map.occasioncalendar '/:customer_key/occasions/calendar', :controller =>'occasions', :action =>'calendar'
  map.occasionlist '/:customer_key/occasions/list', :controller =>'occasions', :action =>'list'
  map.resources :occasions, :path_prefix => '/:customer_key'
  map.resources :locations, :path_prefix => '/:customer_key'

  # Tapahtumien massalisäys
  map.with_options :controller => 'occasions/import', :path_prefix => '/:customer_key' do |import|
    import.new_occasion_import 'occasions/import/new', :action => 'new'
    import.refine_occasion_import 'occasions/import/refine', :action => 'refine'
    import.validate_occasion_import 'occasions/import/validate', :action => 'validate'
    import.preview_occasion_import 'occasions/import/preview', :action => 'preview'
    import.create_occasion_import 'occasions/import/create', :action => 'create'
    import.show_occasion_import 'occasions/import/show', :action => 'show'
  end
  map.with_options :controller => 'occasions/export', :path_prefix => '/:customer_key' do |export|
    export.new_occasion_export 'occasions/export/new', :action => 'new'
    export.csv_occasion_export 'occasions/export/csv', :action => 'csv'
  end
  
  map.connect '/:customer_key/:controller/:action/:id'
  map.connect '/:customer_key/:controller/:action/:id.:format'
  map.connect '/:customer_key/admin', :controller => 'users'
  map.connect '/:customer_key/', :controller => 'public'
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "index"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.

end
