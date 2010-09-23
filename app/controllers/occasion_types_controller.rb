class OccasionTypesController < ApplicationController
   before_filter :login_required
  
  # GET /occasion_types
  # GET /occasion_types.xml
  def index
    @occasion_types = OccasionType.find(:all, :order => "name ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @occasion_types }
    end
  end

  # GET /occasion_types/1
  # GET /occasion_types/1.xml
  def show
    @occasion_type = OccasionType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @occasion_type }
    end
  end

  # GET /occasion_types/new
  # GET /occasion_types/new.xml
  def new
    @occasion_type = OccasionType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @occasion_type }
    end
  end

  # GET /occasion_types/1/edit
  def edit
    @occasion_type = OccasionType.find(params[:id])
  end

  # POST /occasion_types
  # POST /occasion_types.xml
  def create
    @occasion_type = OccasionType.new(params[:occasion_type])

    respond_to do |format|
      if @occasion_type.save
#        @occasion_type.update_attribute(:customer_id,current_user.customer_id)
        flash[:notice] = 'Uusi tapahtumatyyppi lisätty.'
        format.html { redirect_to(occasion_type_url(:id => @occasion_type)) }        
        format.xml  { render :xml => @occasion_type, :status => :created, :location => @occasion_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @occasion_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /occasion_types/1
  # PUT /occasion_types/1.xml
  def update
    @occasion_type = OccasionType.find(params[:id])

    respond_to do |format|
      if @occasion_type.update_attributes(params[:occasion_type])
        flash[:notice] = 'Tapahtumatyyppin tiedot päivitetty.'
        format.html { redirect_to(occasion_type_url) }     
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @occasion_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /occasion_types/1
  # DELETE /occasion_types/1.xml
  def destroy
    @occasion_type = OccasionType.find(params[:id])
    @occasion_type.destroy

    respond_to do |format|
      format.html { redirect_to(occasion_types_url) }
      format.xml  { head :ok }
    end
  end
end
