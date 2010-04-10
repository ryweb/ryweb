class Occasion  < CustomerData
  belongs_to :location
  belongs_to :occasion_type
  
  validates_presence_of     :name
  validates_presence_of     :state  

  alias_method :orig_location=, :location=
  alias_method :orig_occasion_type=, :occasion_type=

  def location=(new_location)
    if new_location.class == String
      new_location = Location.find_or_create_by_name(new_location)
    end
    self.orig_location = new_location
  end

  def occasion_type=(new_occasion_type)
    if new_occasion_type.class == String
      new_occasion_type = OccasionType.find_or_create_by_name(new_occasion_type)
    end
    self.orig_occasion_type = new_occasion_type
  end

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
         'alustava' => 10,
         'vahvistettu' => 20,
         'peruttu' => 30
       }
      when :repeat
       @options = {
         'ei toistoa' => 0,
         'kerran viikossa' => 10,
         #'kerran kuukaudessa' => 20,
         #'kerran vuodessa' => 30
       }
   when :inform_changes
      @options = {
        'ei' => 0,
        'kyllä' => 1
      }
   end
  end

  def self.inform_yes
    1
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

   def start_date_month_str
 	    month_only_str(start_time)
 	  end
 
  def start_date_only_str
    date_only_str(start_time)
  end

  def start_time_only_str
    time_only_str(start_time)
  end

  def start_date_week_str
    week_only_str(start_time)
  end
 
 private
  def month_only_str(time)
 	    unless time.nil?
 	      time.strftime("%m")
 	    end
 	  end
   def date_only_str(time)
    unless time.nil?
      time.strftime("%d.%m.%Y")
    end
  end

  def time_only_str(time)
    unless time.nil?
      time.strftime("%H:%M")
    end
  end

  def week_only_str(time)
    unless time.nil?
      time.strftime("%W")
    end
  end
end
