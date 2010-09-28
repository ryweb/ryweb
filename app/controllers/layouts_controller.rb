class LayoutsController < ApplicationController
  filter_resource_access
  before_filter :login_required

  # GET /layouts
  # GET /layouts.xml
  def index
    @layouts = Layout.with_permissions_to(:index).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @layouts }
    end
  end

  # GET /layouts/1
  # GET /layouts/1.xml
  def show
    @layout = Layout.with_permissions_to(:show).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @layout }
    end
  end

  # GET /layouts/new
  # GET /layouts/new.xml
  def new
    @layout = Layout.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @layout }
    end
  end

  # GET /layouts/1/edit
  def edit
    @layout = Layout.with_permissions_to(:edit).find(params[:id])
  end

  # POST /layouts
  # POST /layouts.xml
  def create
    @layout = Layout.new(params[:layout])

    respond_to do |format|
      if @layout.save
        flash[:notice] = 'Ulkoasun luonti onnistui.'
        format.html { redirect_to(layouts_url) }
        format.xml  { render :xml => @layout, :status => :created, :location => @layout }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @layout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /layouts/1
  # PUT /layouts/1.xml
  def update
    @layout = Layout.with_permissions_to(:update).find(params[:id])

    respond_to do |format|
      if @layout.update_attributes(params[:layout])
        flash[:notice] = 'Ulkoasu päivitetty onnistuneesti.'
        format.html { redirect_to(layouts_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @layout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /layouts/1
  # DELETE /layouts/1.xml
  def destroy
    @layout = Layout.with_permissions_to(:destroy).find(params[:id])
    @layout.destroy

    respond_to do |format|
      format.html { redirect_to(layouts_url) }
      format.xml  { head :ok }
    end
  end
end
