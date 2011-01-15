class Room < CustomerData
	has_and_belongs_to_many :bookings
  	validates_presence_of   :name
end
