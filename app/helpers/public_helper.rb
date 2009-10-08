module PublicHelper

  def public_calendar(page)
    calendar_type = page.parameter_calendar_type
    case calendar_type
      when 'list'
      return public_calendar_list(page)
      when 'calendar'
      return public_calendar_calendar(page)
    end
  end

  def public_calendar_list(page)
    calendar_length = page.parameter_calendar_length.to_i
    
    content_tag("table",
                content_tag('tr',
                            content_tag('th',"Tapahtuma") +
                            content_tag('th',"Päivä") +
                            content_tag('th',"Aika") +
                            content_tag('th',"Tyyppi") +
                            content_tag('th',"Paikka") +
                            content_tag('th',"Lisätietoja")
                            ) +
                Occasion.find(:all, :conditions => ["start_time > ? AND start_time < ? AND state = ? ",Time.now, calendar_length.months.from_now,Occasion.state_ready], :order => 'start_time ').map { |occasion|
                  if occasion.occasion_type.public_visible? 
                    content_tag("tr", 
                                content_tag("td",occasion.name) + 
                                content_tag("td",occasion.start_date_only_str) +
                                content_tag("td",occasion.start_time_only_str) +
                                content_tag("td",occasion.occasion_type.name) + 
                                content_tag("td",occasion.location.name) + 
                                content_tag("td",occasion.public_info)
                                )
                  end
                }.join, :id => 'calendar_list')
  end



  def public_calendar_calendar(page)
    "2"
  end
end
