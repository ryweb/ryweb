class GraphicsController < ApplicationController
  def index
    @graphics = Graphic.find(:all, :conditions => {:parent_id => nil}, :order => 'created_at DESC')
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @graphics.to_xml }
    end
  end

  def create
    @graphic = Graphic.new(params[:graphic])
    respond_to do |format|
      if @graphic.save
        #flash[:notice] = ''
        format.html { redirect_to graphics_url(:id => @graphic) }
        format.xml  { head :created, :location => graphics_url(:id => @graphic) }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @graphic.errors.to_xml }
        format.js
      end
    end
  end


  def destroy
    @graphic = Graphic.find(params[:id])
    @graphic.destroy

    respond_to do |format|
      format.html { redirect_to graphics_url }
      format.xml  { head :ok }
      format.js
    end
  end
end
