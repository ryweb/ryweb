class Location < CustomerData
  using_access_control
  has_many :occasions
  validates_presence_of     :name
end
