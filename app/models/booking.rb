class Booking < CustomerData
  has_and_belongs_to_many :rooms
  validates_presence_of   :start_time
  validates_presence_of   :end_time

  def varaamaton?		
    for room in self.rooms
      for b in room.bookings
        if(self.id != b.id)
          return false unless(self.start_time >= b.end_time || self.end_time <= b.start_time)            
        end        
      end
    end		
    return true
  end
end
