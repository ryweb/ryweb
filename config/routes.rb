ActionController::Routing::Routes.draw do |map|
  map.resources :configurations, :path_prefix => '/:customer'

  map.resources :graphics, :path_prefix => '/:customer'
  map.resources :layouts, :path_prefix => '/:customer'

  map.resources :pages, :path_prefix => '/:customer'
  map.resources :customers, :path_prefix => '/:customer'
  map.userlist '/:customer/users/list', :controller => 'users', :action => 'list'
  map.logout '/:customer/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/:customer/login/:id', :controller => 'sessions', :action => 'new'
  map.register '/:customer/register', :controller => 'users', :action => 'create'
  map.signup '/:custome/signup', :controller => 'users', :action => 'new'
  map.resources :users, :path_prefix => '/:customer'
  map.resource :session, :path_prefix => '/:customer'
  map.resources :occasion_types, :path_prefix => '/:customer'
  map.occasioncalendar '/:customer/occasions/calendar', :controller =>'occasions', :action =>'calendar'
  map.occasionlist '/:customer/occasions/list', :controller =>'occasions', :action =>'list'
  map.resources :occasions, :path_prefix => '/:customer'
  map.resources :locations, :path_prefix => '/:customer'
  map.connect '/:customer/:controller/:action/:id'
  map.connect '/:customer/:controller/:action/:id.:format'
  map.connect '/:customer/admin', :controller => 'users'
  map.connect '/:customer/', :controller => 'public'
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
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.

end
