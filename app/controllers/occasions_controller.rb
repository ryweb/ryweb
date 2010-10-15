class OccasionsController < ApplicationController
   before_filter :login_required
   filter_resource_access
   filter_access_to :list, :calendar, :require => :read
   filter_access_to :auto_complete_for_occasion_location_id, :auto_complete_for_occasion_occasion_type_id, :require => [:create, :update]


   skip_before_filter :verify_authenticity_token, :only => [:auto_complete_for_occasion_location_id, :auto_complete_for_occasion_occasion_type_id]   
#   skip_before_filter :verify_authenticity_token
   
  # GET /occasions
  # GET /occasions.xml
  def index
    if params[:view].to_s == "list"
      redirect_to :action => 'list', :start_date =>params[:start_date]
    else
      redirect_to :action => 'calendar', :start_date =>params[:start_date] 
    end
  end

  def list
   @occasion = Occasion.new
  
   select_month

   locations_and_occasion_types
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @occasions }
    end    
  end

  def calendar
   @occasion = Occasion.new
  
   select_month

   locations_and_occasion_types
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @occasions }
    end    
  end    
  # GET /occasions/1
  # GET /occasions/1.xml
  def show
    @occasion = Occasion.with_permissions_to(:show).find(params[:id])

    # Varautuminen siihen, että paikkaa ja tapahtumatyyppiä ei ole annettu (eivät pakollisia)
    locations_and_occasion_types

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @occasion }
    end
  end

  # GET /occasions/new
  # GET /occasions/new.xml
  def new
    @occasion = Occasion.new
    unless params[:occasion_date].nil?
      @occasion.start_time = params[:occasion_date]
      @occasion.start_time = @occasion.start_time + 8.hours
    end
    
    locations_and_occasion_types

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @occasion }
    end
  end

  # GET /occasions/1/edit
  def edit
    @occasion = Occasion.with_permissions_to(:edit).find(params[:id])

    # Varautuminen siihen, että paikkaa ja tapahtumatyyppiä ei ole annettu (eivät pakollisia)
    locations_and_occasion_types
  end

  # POST /occasions
  # POST /occasions.xml
  def create
    @occasion = Occasion.new(params[:occasion])

    find_or_create_locations_and_occasion_types
    
    respond_to do |format|
      if @occasion.save
        case params[:occasion][:repeat].to_s
         when '10'
           repeat_until_date = DateTime.new(params[:occasion][:"repeat_until(1i)"].to_i,params[:occasion][:"repeat_until(2i)"].to_i,params[:occasion][:"repeat_until(3i)"].to_i,params[:occasion][:"start_time(4i)"].to_i,params[:occasion][:"start_time(5i)"].to_i)
           @occasion.repeat_weekly(@occasion, repeat_until_date)
        end

        select_month
        
        flash[:notice] = 'Tapahtuma lisätty!'
        
        # Välitetään luodun tapahtuman päiväys, jotta osataan näyttää oikea kuukausi

        if params[:view]
          format.html { redirect_to(occasions_url(:start_date => @occasion.start_time, :view => params[:view]))}
          format.xml  { head :ok }
          format.js
        else
          format.html { redirect_to(occasions_url(:start_date => @occasion.start_time))}
          format.xml  { head :ok }
          format.js        
        end      
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @occasion.errors, :status => :unprocessable_entity }
       format.js        
      end
    end
  end

  # PUT /occasions/1
  # PUT /occasions/1.xml
  def update
    @occasion = Occasion.with_permissions_to(:update).find(params[:id])
    find_or_create_locations_and_occasion_types

    respond_to do |format|
      if @occasion.update_attributes(params[:occasion])
        flash[:notice] = 'Tapahtuman tiedot päivitetty.'
        select_month
         
        if params[:view]
          format.html { redirect_to(occasions_url(:start_date => @occasion.start_time, :view => params[:view]))}
          format.xml  { head :ok }          
        else
          format.html { redirect_to(occasions_url(:start_date => @occasion.start_time))}
          format.xml  { head :ok }          
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @occasion.errors, :status => :unprocessable_entity }
      end
    end
  end

  def bulk_change
    @occasions = Occasion.with_permissions_to(:manage).find(params[:ids])
    
    @occasions.each do |row|
      @occ = Occasion.find(row)
      @occ.state = params["occasion"][:state]
      @occ.save
    end

    # get other occasions
    select_month
    
    respond_to do |format|
           flash[:notice] = 'Tapahtuman tiedot päivitetty.'
          format.xml  { head :ok }
          format.js
    end
  end

  # DELETE /occasions/1
  # DELETE /occasions/1.xml
  def destroy
    @occasion = Occasion.with_permissions_to(:destroy).find(params[:id])

    select_month
    
    @occasion.destroy

    respond_to do |format|
      flash[:notice] = 'Tapahtuma poistettu!'
      if params[:view]
        #format.html { redirect_to(occasions_url(:view => params[:view])) }
        format.html { redirect_to(occasions_url(:start_date => @occasion.start_time, :view => params[:view]))}
      else
        format.html { redirect_to(occasions_url(:start_date => @occasion.start_time)) }
      end
      format.xml  { head :ok }
    end
  end  

  # Autocomplete fields
  def auto_complete_for_occasion_location_id
          @locations = Location.find( :all, :conditions => [ "name LIKE ?", "%#{params[:occasion][:location_id]}%" ] )
          render :partial => 'locations'
  end   

  def auto_complete_for_occasion_occasion_type_id
          @occasion_types = OccasionType.find( :all, :conditions => [ "name LIKE ?", "%#{params[:occasion][:occasion_type_id]}%" ] )
          render :partial => 'occasion_types'
  end   
  
###########
  private
###########  

  def locations_and_occasion_types
    @occasion_types = OccasionType.find(:all)
    @occasion.occasion_type = OccasionType.new unless @occasion.occasion_type
    @occasion_type = @occasion.occasion_type
    @occasion.location = Location.new unless @occasion.location
    @locations = Location.find(:all)
    @location = @occasion.location
  end
  
  def find_or_create_locations_and_occasion_types
    occasion_name = params[:occasion][:location_id]
    @occasion.location = Location.find_or_create_by_name(:name => occasion_name)

    params[:occasion][:location_id] = @occasion.location.id
    
    occasion_type_name = params[:occasion][:occasion_type_id]
    @occasion.occasion_type = OccasionType.find_or_create_by_name(:name => occasion_type_name)

    params[:occasion][:occasion_type_id] = @occasion.occasion_type.id
  end
  
  def select_month
     if params[:year]
        new_date = Date.new(params[:year].to_i,params[:month].to_i)

        if params[:direction] =='back'
          new_date = new_date.advance(:months => -1)
        elsif params[:direction] == 'forward'
          new_date = new_date.advance(:months => 1)
        end

       first_date = new_date.beginning_of_month # first day at 0:00:00
       last_date = first_date
       last_date = last_date.advance(:months => 1)
       last_date = last_date.beginning_of_month # first day of next month at 0:00:00

      @occasions = Occasion.find(:all, :conditions => ["start_time > ? AND start_time < ?", first_date.to_date, last_date.to_date],:order => "start_time ASC")

      @date = new_date
      else
       if params[:start_date]
        date_now = DateTime.parse(params[:start_date])
       else
          date_now = DateTime.now                
       end

       first_date = date_now.beginning_of_month # first day at 0:00:00
       last_date = date_now.advance(:months => 1)
       last_date = last_date.beginning_of_month # first day of next month at 0:00:00

       @occasions = Occasion.find(:all, :conditions => ["start_time > ? AND start_time < ?", first_date.to_date, last_date.to_date],:order => "start_time ASC")
       @date = date_now
   end
  end
end
