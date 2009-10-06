class Occasion  < CustomerData
  belongs_to :location
  belongs_to :occasion_type
  
  validates_presence_of     :name
  validates_presence_of     :state  
  
  def getOptionsForSelectList(method)
   case method
     when :state
       @options = {
         'luonnos' => 10,
         'valmis' => 20,
         'peruttu' => 30
       }
   end
 end

  def monthname
    @monthname = %w{tammi helmi maalis huhti touko kesä heinä elo syys loka marras joulu}
  end
 
  def start_date_only_str
    date_only_str(start_time)
  end

  def start_time_only_str
    time_only_str(start_time)
  end
 
 private
   def date_only_str(time)
    unless time.nil?
      time.strftime("%d.%m.%y")
    end
  end

  def time_only_str(time)
    unless time.nil?
      time.strftime("%H:%M")
    end
  end
end
