class Customer < ActiveRecord::Base
  has_many :users
end
