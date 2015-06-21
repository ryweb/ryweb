# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def calendar?
    if params[:view].to_s == "list"
      true
    else
      false
    end
  end

  def highlight_current(args)
    if args.include?(params[:controller])
      if !(params[:controller] == 'users' && params[:action] == 'index')
        return ' class="current"'
      end
    end
  end
  
  # Helper for calculating European week number
  # Returns week number as string when time object is given as input
  # Usage: week_number(date) for most European countries.
  #
  # Rules: 	1) First thursday of the year is inside first week
  #					2) 28.12. is inside of the last week
  #
  # NOTE: Week definition is diffent in USA and some other countries, see ISO8601 standard

  def week_number(date)
    week_number = tmp_week_number(date)
    
    # Week number may already 1 at the end of December
    if week_number > tmp_week_number(Date.civil(date.year,12,28))
      week_number = 1
    end
    
    # Week number may be equal to last week of the previous year at the beginning of January
    if week_number < 1 
      week_number = tmp_week_number(Date.civil(date.year-1,12,28))
    end
    
    week_number.to_s
  end
 
  private
  
  # Subfunction for calculating week number. Does not work correcty near New Year
  def tmp_week_number(date)
    weekday = date.wday
    weekday +=7 if weekday == 0   	# Sunday shift
    yearday = date.yday
    
    # Perform shift to be sure that we remain in the same year
    shift = 14
    if yearday < 180
    	thursday_of_same_week = (date+(4-weekday+shift)).yday-shift
    else
    	thursday_of_same_week = (date+(4-weekday-shift)).yday+shift
    end
    
    thursday_of_first_week = 1
    until Date.civil(date.year,1,thursday_of_first_week).wday == 4
      thursday_of_first_week += 1
    end
    
    day_difference = thursday_of_same_week-thursday_of_first_week
    week_number = (day_difference/7+1).to_i    
  end
  
end
