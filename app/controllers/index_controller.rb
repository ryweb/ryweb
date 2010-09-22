class IndexController < ApplicationController
  
  # GET /customers
  # GET /customers.xml
  def index
    @customers = Customer.find(:all)

    respond_to do |format|
      format.html { render :layout => false }# index.html.erb
      format.xml  { render :xml => @customers }
    end
  end

  # GET /customers/1
  # GET /customers/1.xml
  def show
    @customer = Customer.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false }# show.html.erb
      format.xml  { render :xml => @customer }
    end
  end

  def occasions
    @customer = Customer.find(params[:id])
    Customer.current = @customer
    calendar_length = 5
     date_now = DateTime.now
    last_date = date_now.advance(:months => calendar_length)
    @occasions = Occasion.find(:all, :joins => :occasion_type, :conditions => ["start_time >= ? AND start_time < ? AND state = ? AND occasion_types.visibility = ? ", DateTime.now.beginning_of_day, last_date, 20,20], :order => 'start_time ')

    respond_to do |format|
      #      format.xml  { render :xml => @occasions_xml}
      format.xml  { render :layout => false}
    end

  end

  def locations
    @customer = Customer.find(params[:id])
    Customer.current = @customer

    @locations = Location.find(:all)

    respond_to do |format|
      format.xml  { render :xml => @locations}
    end

  end

end
