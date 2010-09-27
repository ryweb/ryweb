authorization do
  role :superadmin do
    has_permission_on :customers, :to => [:manage]
    has_permission_on :people, :members, :speakers, :to => [:manage]
  end

  role :admin do
    has_permission_on :customers, :to => [:manage] do
      if_attribute :id => is {user.customer_id}
    end

    has_permission_on :people, :members, :speakers, :to => [:manage] do
      if_attribute :id => is {user.customer_id}
    end
  end

  role :standard do
  end
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end