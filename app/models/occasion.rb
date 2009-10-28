class Occasion  < CustomerData
  belongs_to :location
  belongs_to :occasion_type
  
  validates_presence_of     :name
  validates_presence_of     :state  

  def repeat_weekly(occasion, repeat_until)
  
    while occasion.start_time.advance(:weeks => 1) < repeat_until
      recurring_occasion = occasion.clone
      recurring_occasion.start_time = occasion.start_time.advance(:weeks => 1)
      
      recurring_occasion.save
      occasion = recurring_occasion
    end
  end

  def getOptionsForSelectList(method)
   case method
     when :state
       @options = {
         'luonnos' => 10,
         'valmis' => 20,
         'peruttu' => 30
       }
      when :repeat
       @options = {
         'ei toistoa' => 0,
         'kerran viikossa' => 10,
         #'kerran kuukaudessa' => 20,
         #'kerran vuodessa' => 30
       }
   end
  end

  def self.state_ready
    20
  end
    

  def ready?
    state == 20
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
