class CustomerData < ActiveRecord::Base
  self.abstract_class = true

  def self.scope_conditions
    return {:find => { :conditions => {:customer_id => Customer.current_id}} ,:create => {:customer_id => Customer.current_id }}
  end
  
  def initialize(*args)
    super
    self.customer_id = Customer.current_id
  end
  

  def self.find(*args)
    retval = nil
    with_scope(CustomerData.scope_conditions) do
      retval = super
    end

    if retval.nil?      
      user = super
      if user.is_a? User
        unless user.nil?
          unless user.superuser?
            user = nil
          end
        end
        retval = user
      end
    end
    return retval
  end

  def self.create(*args)
    with_scope(CustomerData.scope_conditions) do
      super
    end
  end
  
  def self.update(*args)
    with_scope(CustomerData.scope_conditions) do
      super
    end
  end

  def self.calculate(*args)
    with_scope(CustomerData.scope_conditions) do
      super
    end
  end

end
