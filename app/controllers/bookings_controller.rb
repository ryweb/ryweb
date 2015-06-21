class BookingsController < ApplicationController
   before_filter :login_required
  
  # GET /bookings
  # GET /bookings.xml
  def index
    @bookings=Booking.find(:all,:conditions => ['start_time > ?',Time.now]).sort{|a,b| a.start_time<=>b.start_time}		

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookings }
    end
  end

  # GET /bookings/1
  # GET /bookings/1.xml
  def show
    @bookings=Booking.find(:all,:conditions => ['start_time > ?',Time.now])  	
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @booking }
    end
  end

  # GET /bookings/new
  # GET /bookings/new.xml
  def new
    @booking = Booking.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @booking }
    end
  end

  # GET /bookings/1/edit
  def edit
    @booking = Booking.find(params[:id])
  end

  # POST /bookings
  # POST /bookings.xml
  def create
    @booking = Booking.new(params[:booking])    
    @booking.week = @booking.start_time.strftime("%W").to_i
    
# TODO: Suomalainen viikko menee eri tavalla kuin yllä laskettu amerikkalainen viikko
# tämä hoidetaan erillisellä funktiolla

#   @minutes = params[:duration].to_i
#   @booking.end_time = @booking.start_time + @minutes.minutes
# TODO: ylläoleva täytyy tarkistaa
				
    respond_to do |format|
      if @booking.varaamaton?
        if @booking.save
          flash[:notice] = 'Uusi tilanvaraus lisätty.'
          format.html { redirect_to(booking_url(:id => @booking)) }
          format.xml  { render :xml => @booking, :status => :created, :booking => @booking }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
        end
      else
        flash[:notice] = 'Ei voida tallentaa, tila käytössä!'
        format.html { render :action => "new" }
        format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bookings/1
  # PUT /bookings/1.xml
  def update
    @booking = Booking.find(params[:id])
	 
    respond_to do |format|
     if @booking.varaamaton?
       if @booking.update_attributes(params[:booking])
         flash[:notice] = 'Tilanvarausta päivitetty.'
         format.html { redirect_to(booking_url) }
         format.xml  { head :ok }
       else
         format.html { render :action => "edit" }
         format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
       end
     else
       flash[:notice] = 'Ei voida tallentaa, tila käytössä!'
       format.html { render :action => "edit" }
       format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
       end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.xml
  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to(bookings_url) }
      format.xml  { head :ok }
    end
  end
end
