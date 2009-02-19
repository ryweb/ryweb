class OccasionsController < ApplicationController
   before_filter :login_required
   
  # GET /occasions
  # GET /occasions.xml
  def index
#    @occasions = Occasion.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @occasions }
    end
  end

  # GET /occasions/1
  # GET /occasions/1.xml
  def show
    @occasion = Occasion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @occasion }
    end
  end

  # GET /occasions/new
  # GET /occasions/new.xml
  def new
    @occasion = Occasion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @occasion }
    end
  end

  # GET /occasions/1/edit
  def edit
    @occasion = Occasion.find(params[:id])
  end

  # POST /occasions
  # POST /occasions.xml
  def create
    @occasion = Occasion.new(params[:occasion])

    respond_to do |format|
      if @occasion.save
        flash[:notice] = 'Occasion was successfully created.'
        format.html { redirect_to(@occasion) }
        format.xml  { render :xml => @occasion, :status => :created, :location => @occasion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @occasion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /occasions/1
  # PUT /occasions/1.xml
  def update
    @occasion = Occasion.find(params[:id])

    respond_to do |format|
      if @occasion.update_attributes(params[:occasion])
        flash[:notice] = 'Occasion was successfully updated.'
        format.html { redirect_to(@occasion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @occasion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /occasions/1
  # DELETE /occasions/1.xml
  def destroy
    @occasion = Occasion.find(params[:id])
    @occasion.destroy

    respond_to do |format|
      format.html { redirect_to(occasions_url) }
      format.xml  { head :ok }
    end
  end
end
