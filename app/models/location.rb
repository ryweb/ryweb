class Location < CustomerData
  has_many :occasions
  validates_presence_of     :name
end
