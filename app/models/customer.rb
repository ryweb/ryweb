class Customer < ActiveRecord::Base
  has_many :users

  def self.current
    Thread.current['customer']
  end

  def self.current_id
    Thread.current['customer'].id or nil
  end

  def self.current=(customer)
    case customer
    when Integer
      cust = Customer.find(customer)
    when String
      cust = Customer.find_by_name(customer)
    when Customer
      cust = customer
    else
      raise TypeError
    end
    Thread.current['customer'] = cust
  end
  
end
