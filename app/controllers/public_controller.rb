class PublicController < ApplicationController
  layout 'public'

  before_filter :set_layout
  before_filter :generate_menu

  def index
    default_page = Configuration.get_one('default_page')
    if default_page.nil?
      render :text => "Oletussivua ei ole määritetty"
      return
    end

    redirect_to(:action => 'page', :id => default_page.to_i)
  end


  def page
    @page = Page.find(params[:id])
    if @page.nil? or @page.public == 0 or @page.state != 2
      render :text => 'Virheellinen sivu'
      return
    end

    calendar_length = @page.parameter_calendar_length.to_i
    
      date_now = DateTime.now
      first_date = date_now.beginning_of_month # first day at 0:00:00
      last_date = date_now.advance(:months => calendar_length)
      last_date = last_date.beginning_of_month # first day of next month at 0:00:00

    @modified_occasions = Occasion.find(:all, :joins => :occasion_type, :conditions => ["start_time >= ? AND start_time < ? AND state = ? AND occasion_types.visibility = ? AND inform_changes = ? ", Time.now.beginning_of_day, last_date, 20,20, true], :order => 'start_time ')
    @occasions = Occasion.find(:all, :joins => :occasion_type, :conditions => ["start_time >= ? AND start_time < ? AND state = ? AND occasion_types.visibility = ? ", DateTime.now.beginning_of_day, last_date, 20,20], :order => 'start_time ')

    @layout = @page.layout
  end

  private
  def set_layout
    @layout = Layout.find(:first)
  end

  def generate_menu
    @mainmenu = Page.find(:all, :conditions => {:public => 1, :state => 2})
  end
  


end
