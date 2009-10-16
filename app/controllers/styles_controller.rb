class StylesController < ApplicationController
def index
    @styles = Style.find(:all, :conditions => {:parent_id => nil}, :order => 'created_at DESC')
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @styles.to_xml }
    end
  end

  def create
    @style = Style.new(params[:style])
    respond_to do |format|
      if @style.save
        #flash[:notice] = ''
        format.html { redirect_to styles_url(:id => @style) }
        format.xml  { head :created, :location => styles_url(:id => @style) }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @style.errors.to_xml }
        format.js
      end
    end
  end

def show
    @style = Style.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @style.to_xml }
    end
  end

  def destroy
    @style = Style.find(params[:id])
    @style.destroy

    respond_to do |format|
      format.html { redirect_to styles_url }
      format.xml  { head :ok }
      format.js
    end
  end

  def edit
    @style = Style.find(params[:id])
  end

  def update
    @style = Style.find(params[:id])

    respond_to do |format|
      if @style.update_attributes(params[:style])

        format.html { redirect_to styles_url }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @style.errors.to_xml }
      end
    end
  end

end
