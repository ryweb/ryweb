class PublicController < ApplicationController
  layout 'public'

  require 'rss/2.0'
  require 'open-uri'

  before_filter :set_layout
  before_filter :generate_menu
  before_filter :set_locale


  def index
    default_page = Configuration.get_one('default_page')
    if default_page.nil?
      render :text => t('public.no_default_page')
      return
    end

    redirect_to(:action => 'page', :id => default_page.to_i)
  end


  def page
    @page = Page.find(params[:id])
    if @page.nil? or @page.public == 0 or @page.state != 2
      render :text => t('public.page_not_found')
      return
    end

    # Prepare for anti_spam email
    @customer = Customer.current

    if !@customer.email.empty?
      tmp1, tmp2 = @customer.email.split(/\.([^.]*)$/)
      @user, @organization = tmp1.split(/\@([^@]*)$/)
      @domain = tmp2
    end

    # Variables for date counting
    calendar_length = @page.parameter_calendar_length.to_i

    date_now = DateTime.now
    first_date = date_now.beginning_of_month # first day at 0:00:00
    last_date = date_now.advance(:months => calendar_length)
    last_date = last_date.beginning_of_month # first day of next month at 0:00:00
    
    # Database access only if page contains a calendar
    if @page.page_type == 2

      @modified_occasions = Occasion.find(:all, :joins => :occasion_type, :conditions => ["start_time >= ? AND start_time < ? AND (state = ? OR state =?) AND occasion_types.visibility = ? AND inform_changes = ? ", Time.now.beginning_of_day, last_date, 20,30, 20, true], :order => 'start_time ')

      @occasions = Occasion.find(:all, :joins => :occasion_type, :conditions => ["start_time >= ? AND start_time < ? AND state = ? AND occasion_types.visibility = ? ", DateTime.now.beginning_of_day, last_date, 20,20], :order => 'start_time ')

    end

    # Database access only if page contains calendar gadgets
    if @page.show_gadgets?
      last_date = date_now.advance(:weeks => 1)
      @next_occasions = Occasion.find(:all, :joins => :occasion_type, :conditions => ["start_time >= ? AND start_time < ? AND state = ? AND occasion_types.visibility = ? ", DateTime.now.beginning_of_day, last_date, 20,20], :order => 'start_time ')
    end

    # Choose whether to use general UI template or customized layouts
    if Customer.current.ui_template.nil?
      @layout = @page.layout
    else
      @layout = Customer.current.ui_template
    end
  end
  
  private
  def set_layout
    @layout = Layout.find(:first)
  end

  def generate_menu
    @mainmenu = Page.find(:all, :conditions => {:public => 1, :state => 2}, :order => :menu_order)
  end

  def set_locale
    current_customer = params[:customer]
   I18n.locale = Customer.current.language
  end

end
