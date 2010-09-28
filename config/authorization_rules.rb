authorization do
  # Super admin is allowed to manage all models
  role :superadmin do
    has_permission_on :customers, :to => [:manage]
    has_permission_on :ui_templates, :to => [:manage]
    has_permission_on :users, :to => [:manage]
    has_permission_on :pages,:layouts, :graphics, :styles, :to => [:manage]
    has_permission_on :people, :members, :to => [:manage]
    has_permission_on :occasions, :occasion_types, :locations, :to => [:manage]
  end

  role :admin do
  # Admin is allowed to manage all models in a certain customer context
  # Notice! Usually attribute checks are not needed, since almost every Active Record calls implements the named scope (customer.current)

    # Manage users of own customer
    has_permission_on :users, :to => [:manage]

    # Read and update own customer information
    has_permission_on :customers, :to => [:own] do
        if_attribute :id => is {user.customer_id}
    end

    # Manage occasions, occasion_types and locations of own customer
    has_permission_on :occasions, :occasion_types, :locations, :to => [:manage]

    # Manage web pages and the related models
    has_permission_on :pages, :layouts, :graphics, :styles, :to => [:manage]

    has_permission_on :people, :members, :to => [:manage] do
      if_attribute :id => is {user.customer_id}
    end
  end

  role :standard do
    # Standard user is allowed to read and update his own user information
    has_permission_on :users, :to => [:own] do
      if_attribute :id => is {user.id}
    end

    # Read occasions and the related information
    has_permission_on :occasions, :occasion_types, :locations, :to => [:read]
  end
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy

  # custom privilages for ryweb
  privilege :own, :includes => [:read, :update]
end
