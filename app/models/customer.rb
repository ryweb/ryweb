class Customer < ActiveRecord::Base
  has_many :users

  def self.current
    Thread.current['customer']
  end

  def self.current_id
    unless Customer.current.nil?
      Customer.current.id
    else
      nil
    end
  end

  def self.current=(customer)
    cust = nil
    case customer
    when Integer
      cust = Customer.find(customer)
    when String
      cust = Customer.find_by_name(customer)
    when Customer
      cust = customer
    when nil
      cust = nil
    end
    Thread.current['customer'] = cust
  end
  
end
