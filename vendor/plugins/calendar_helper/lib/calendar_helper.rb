require 'date'

# CalendarHelper allows you to draw a databound calendar with fine-grained CSS formatting
module CalendarHelper

  VERSION = '0.2.2'

  # Returns an HTML calendar. In its simplest form, this method generates a plain
  # calendar (which can then be customized using CSS) for a given month and year.
  # However, this may be customized in a variety of ways -- changing the default CSS
  # classes, generating the individual day entries yourself, and so on.
  # 
  # The following options are required:
  #  :year  # The  year number to show the calendar for.
  #  :month # The month number to show the calendar for.
  # 
  # The following are optional, available for customizing the default behaviour:
  #   :table_class       => "calendar"        # The class for the <table> tag.
  #   :month_name_class  => "monthName"       # The class for the name of the month, at the top of the table.
  #   :other_month_class => "otherMonth" # Not implemented yet.
  #   :day_name_class    => "dayName"         # The class is for the names of the weekdays, at the top.
  #   :day_class         => "day"             # The class for the individual day number cells.
  #                                             This may or may not be used if you specify a block (see below).
  #   :abbrev            => (0..2)            # This option specifies how the day names should be abbreviated.
  #                                             Use (0..2) for the first three letters, (0..0) for the first, and
  #                                             (0..-1) for the entire name.
  #   :first_day_of_week => 0                 # Renders calendar starting on Sunday. Use 1 for Monday, and so on.
  #   :accessible        => true              # Turns on accessibility mode. This suffixes dates within the
  #                                           # calendar that are outside the range defined in the <caption> with 
  #                                           # <span class="hidden"> MonthName</span>
  #                                           # Defaults to false.
  #                                           # You'll need to define an appropriate style in order to make this disappear. 
  #                                           # Choose your own method of hiding content appropriately.
  #
  #   :show_today        => false             # Highlights today on the calendar using the CSS class 'today'. 
  #                                           # Defaults to true.
  #   :previous_month_text   => nil           # Displayed left of the month name if set
  #   :next_month_text   => nil               # Displayed right of the month name if set
  #
  # For more customization, you can pass a code block to this method, that will get one argument, a Date object,
  # and return a values for the individual table cells. The block can return an array, [cell_text, cell_attrs],
  # cell_text being the text that is displayed and cell_attrs a hash containing the attributes for the <td> tag
  # (this can be used to change the <td>'s class for customization with CSS).
  # This block can also return the cell_text only, in which case the <td>'s class defaults to the value given in
  # +:day_class+. If the block returns nil, the default options are used.
  # 
  # Example usage:
  #   calendar(:year => 2005, :month => 6) # This generates the simplest possible calendar.
  #   calendar({:year => 2005, :month => 6, :table_class => "calendar_helper"}) # This generates a calendar, as
  #                                                                             # before, but the <table>'s class
  #                                                                             # is set to "calendar_helper".
  #   calendar(:year => 2005, :month => 6, :abbrev => (0..-1)) # This generates a simple calendar but shows the
  #                                                            # entire day name ("Sunday", "Monday", etc.) instead
  #                                                            # of only the first three letters.
  #   calendar(:year => 2005, :month => 5) do |d| # This generates a simple calendar, but gives special days
  #     if listOfSpecialDays.include?(d)          # (days that are in the array listOfSpecialDays) one CSS class,
  #       [d.mday, {:class => "specialDay"}]      # "specialDay", and gives the rest of the days another CSS class,
  #     else                                      # "normalDay". You can also use this highlight today differently
  #       [d.mday, {:class => "normalDay"}]       # from the rest of the days, etc.
  #     end
  #   end
  #
  # An additional 'weekend' class is applied to weekend days. 
  #
  # For consistency with the themes provided in the calendar_styles generator, use "specialDay" as the CSS class for marked days.
  #

  #$month_names = ["","Tammikuu","Helmikuu","Maaliskuu","Huhtikuu","Toukokuu","Kesäkuu","Heinäkuu","Elokuu","Syyskuu","Lokakuu","Marraskuu","Joulukuu"]
  def calendar(options = {}, &block)
    raise(ArgumentError, "No year given")  unless options.has_key?(:year)
    raise(ArgumentError, "No month given") unless options.has_key?(:month)

    block                        ||= Proc.new {|d| nil}

    defaults = {
      :table_class => 'calendar',
      :month_name_class => 'monthName',
      :other_month_class => 'otherMonth',
      :day_name_class => 'dayName',
      :day_class => 'day',
      :abbrev => (0..2),
      :first_day_of_week => 0,
      :accessible => false,
      :show_today => true,
      :previous_month_text => nil,
      :next_month_text => nil
    }
    $holName = ""
    options = defaults.merge options

    first = Date.civil(options[:year], options[:month], 1)
    last = Date.civil(options[:year], options[:month], -1)

    first_weekday = first_day_of_week(options[:first_day_of_week])
    last_weekday = last_day_of_week(options[:first_day_of_week])
    
#    day_names = Date::DAYNAMES.dup
    day_names = ["Sunnuntai","Maanantai","Tiistai","Keskiviikko","Torstai","Perjantai","Lauantai"]
    month_names = ["","Tammikuu","Helmikuu","Maaliskuu","Huhtikuu","Toukokuu","Kesäkuu","Heinäkuu","Elokuu","Syyskuu","Lokakuu","Marraskuu","Joulukuu"]
    first_weekday.times do
      day_names.push(day_names.shift)
    end

    # TODO Use some kind of builder instead of straight HTML
    cal = %(<table class="#{options[:table_class]}" border="0" cellspacing="0" cellpadding="0">)
    cal << %(<thead>)
    cal << %(<tr class="#{options[:day_name_class]}">)
    cal << %(<th scope='col' id="week_number"></th>)    # Add empty cell for before day names (MaLi)
       
    day_names.each do |d|
      unless d[options[:abbrev]].eql? d
        cal << "<th scope='col'><abbr title='#{d}'>#{d[options[:abbrev]]}</abbr></th>"
      else
        cal << "<th scope='col'>#{d[options[:abbrev]]}</th>"
      end
    end
    cal << "</tr></thead><tbody><tr>"
    cal << %(<td scope='col' id="week_number">)+week_number(beginning_of_week(first,first_weekday))+"</td>" unless first.wday == first_weekday  # Week number for the first week (MaLi)
    beginning_of_week(first, first_weekday).upto(first - 1) do |d|
      cal << %(<td class="#{options[:other_month_class]})
      cal << " weekendDay" if weekend?(d)
      if options[:accessible]
        cal << %(">#{d.day}<span class="hidden"> #{Date::MONTHNAMES[d.month]}</span></td>)
      else
        cal << %(">#{d.day}</td>)
      end
    end unless first.wday == first_weekday
    first.upto(last) do |cur|
      cell_text, cell_attrs = block.call(cur)
      cell_text  ||= cur.mday
      cell_attrs ||= {}
      cell_attrs[:class] ||= options[:day_class]
      cell_attrs[:class] += " weekendDay" if [0, 6].include?(cur.wday) 
      testD = Date.civil(cur.year, cur.month, cur.mday)
      hol_str = holiday(testD)
      cell_attrs[:class] += " specialDay" if hol_str != ""
      cell_attrs[:class] += " today" if (cur == Date.today) and options[:show_today]  
      cell_attrs = cell_attrs.map {|k, v| %(#{k}="#{v}") }.join(" ")
      cal << %(<td scope='col' id="week_number">)+week_number(cur)+"</td>" if cur.wday == first_weekday     # Week number of other weeks (MaLi)
      cal << "<td #{cell_attrs}>#{cell_text}</td>"
      cal << "</tr><tr>" if cur.wday == last_weekday
    end
    (last + 1).upto(beginning_of_week(last + 7, first_weekday) - 1)  do |d|
      cal << %(<td class="#{options[:other_month_class]})
      cal << " weekendDay" if weekend?(d)
      if options[:accessible]
        cal << %(">#{d.day}<span class='hidden'> #{Date::MONTHNAMES[d.mon]}</span></td>)
      else
        cal << %(">#{d.day}</td>)        
      end
    end unless last.wday == last_weekday
    cal << "</tr></tbody></table>"
  end

  def navigation_back(args)
     month_names = ["","Tammikuu","Helmikuu","Maaliskuu","Huhtikuu","Toukokuu","Kesäkuu","Heinäkuu","Elokuu","Syyskuu","Lokakuu","Marraskuu","Joulukuu"]
    ret = ""
    3.downto(1) { |i|
      if @date.month - i < 1
        previous_month = @date.month - i + 12
      else
        previous_month = @date.month - i
      end

      if @date.month - i < 0
       this_month = @date.month + 13 - i
       previous_year = -1
      else
        this_month = @date.month-(i-1)
        previous_year = 0
      end
      ret += "<li>#{link_to "&laquo;&laquo;&nbsp;" + month_names[previous_month], :controller => 'occasions', :action => args[:view], :direction => 'back', :year => @date.year+previous_year, :month => this_month}</li>"

    }
  return ret
  end

  def navigation_forward(args)
    month_names = ["","Tammikuu","Helmikuu","Maaliskuu","Huhtikuu","Toukokuu","Kesäkuu","Heinäkuu","Elokuu","Syyskuu","Lokakuu","Marraskuu","Joulukuu"]
    ret = ""

    for i in (1..3)
     if @date.month + i > 12
       next_month = @date.month + i - 12
      else
        next_month = @date.month + i
      end
     if @date.month + i > 13
       this_month = @date.month+(i-13)
       next_year = 1
     else
       this_month = @date.month+(i-1)
       next_year = 0
     end

      ret += "<li>#{link_to month_names[next_month] + "&nbsp;&raquo;&raquo;", :controller => 'occasions', :action => args[:view], :direction => 'forward', :year => @date.year + next_year, :month => this_month}</li>"
   end
   
   return ret
  end
  
  private
  
  def first_day_of_week(day)
    day
  end
  
  def last_day_of_week(day)
    if day > 0
      day - 1
    else
      6
    end
  end
  
  def days_between(first, second)
    if first > second
      second + (7 - first)
    else
      second - first
    end
  end
  
  def beginning_of_week(date, start = 1)
    days_to_beg = days_between(start, date.wday)
    date - days_to_beg
  end
  
  def weekend?(date)
    [0, 6].include?(date.wday)
  end
  
  def holiday(date)
	if date.month == 1 && date.mday == 1
		return " Uudenv.pv."
	end
	if date.month == 1 && date.mday == 6
		return " Loppiainen"
	end
	if date.month == 5 && date.mday == 1
		return " Vappu"
	end
	if date.month == 5 && date.mday >= 8 && date.mday <= 14 && date.wday == 0
		return " Äitienpv."
	end
	if date.month == 6 && date.mday >= 19 && date.mday <= 25 && date.wday == 5
		return " Juh. aatto"
	end
	if date.month == 6 && date.mday >= 20 && date.mday <= 26 && date.wday == 6
		return " Juhannuspv."
	end
	if date.month == 10 && date.mday == 31 && date.wday == 6
		return " Pyhäinpäivä"
	end
	if date.month == 11 && date.mday >= 1 && date.mday <= 6 && date.wday == 6
		return " Pyhäinpäivä"
	end
	if date.month == 12 && date.mday == 6
		return " Itsenäisyyspv."
	end
	if date.month == 12 && date.mday == 24
		return " Jouluaatto"
	end
	if date.month == 12 && date.mday == 25
		return " Joulupäivä"
	end
	if date.month == 12 && date.mday == 26
		return " Tapaninpv."
	end
	if date.month == 12 && date.mday == 31
		return " Uud.v.aatto"
	end
        
# Calculate date of Easter and other holidays depending on it

        aY = date.year

        a = aY % 19;
        b = (aY / 100).floor;
        c = aY % 100;
        d = (b / 4).floor;
        e = b % 4;
        f = ((b + 8) / 25).floor;
        g = ((b - f + 1) / 3).floor;
        h = (19 * a + b - d - g + 15) % 30;
        i = (c / 4).floor;
        k = c % 4;
        l = (32 + 2 * e + 2 * i - h - k) % 7;
        m = ((a + 11 * h + 22 * l) / 451).floor;
        n = ((h + l - 7 * m + 114) / 31).floor;
        o = (h + l - 7 * m + 114) % 31;

	if date.month == n && date.mday == o + 1
		return " Pääsiäinen"
	end
        eDate = Date.civil(aY, n, o + 1)
#           return eDate.strftime()
	if date.month == (eDate-49).month && date.mday == (eDate-49).mday
		return " Laskiaissunn."
	end
	if date.month == (eDate-47).month && date.mday == (eDate-47).mday
		return " Lask.tiistai"
	end
	if date.month == (eDate-2).month && date.mday == (eDate-2).mday
		return " Pitkäperjantai"
	end
	if date.month == (eDate-7).month && date.mday == (eDate-7).mday
		return " Palmusunnuntai"
	end
	if date.month == (eDate+1).month && date.mday == (eDate+1).mday
		return " 2. Pääs.pv."
	end
	if date.month == (eDate+39).month && date.mday == (eDate+39).mday
		return " Helatorstai"
	end
	if date.month == (eDate+49).month && date.mday == (eDate+49).mday
		return " Helluntai"
	end

  return ""
  end
  
end
