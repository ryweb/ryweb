class UiTemplatesController < ApplicationController
  filter_resource_access
  # GET /ui_templates
  # GET /ui_templates.xml
  def index
    @ui_templates = UiTemplate.with_permissions_to(:index).find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ui_templates }
    end
  end

  # GET /ui_templates/1
  # GET /ui_templates/1.xml
  def show
    @ui_template = UiTemplate.with_permissions_to(:show).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ui_template }
    end
  end

  # GET /ui_templates/new
  # GET /ui_templates/new.xml
  def new
    @ui_template = UiTemplate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ui_template }
    end
  end

  # GET /ui_templates/1/edit
  def edit
    @ui_template = UiTemplate.with_permissions_to(:edit).find(params[:id])
  end

  # POST /ui_templates
  # POST /ui_templates.xml
  def create
    @ui_template = UiTemplate.new(params[:ui_template])

    respond_to do |format|
      if @ui_template.save
        flash[:notice] = 'Ulkoasumallin luonti onnistui'
        format.html { redirect_to(ui_templates_url) }
        format.xml  { render :xml => @ui_template, :status => :created, :location => @ui_template }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ui_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ui_templates/1
  # PUT /ui_templates/1.xml
  def update
    @ui_template = UiTemplate.with_permissions_to(:update).find(params[:id])

    respond_to do |format|
      if @ui_template.update_attributes(params[:ui_template])
        flash[:notice] = 'Ulkoasumalli päivitetty onnistuneesti.'
        format.html { redirect_to(ui_templates_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ui_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ui_templates/1
  # DELETE /ui_templates/1.xml
  def destroy
    @ui_template = UiTemplate.with_permissions_to(:destroy).find(params[:id])
    @ui_template.destroy

    respond_to do |format|
      format.html { redirect_to(ui_templates_url) }
      format.xml  { head :ok }
    end
  end
end
