class PagesController < ApplicationController
  before_filter :login_required

# GET /pages
  # GET /pages.xml
  def index

    @pages = Page.find(:all, :order => :menu_order)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  def versions
    @page = Page.find(params[:id])
    @versions = @page.versions.find(:all, :limit => 20)
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @pages }
    end
  end
  
  def diff
    @page = Page.find(params[:id])
    version = params[:version].to_i
    @dpage1 = @page.versions.find(:first, :conditions => {:version => version-1})
    @dpage2 = @page.versions.find(:first, :conditions => {:version => version})
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])
    @page.author_id = current_user.id
    respond_to do |format|
      if @page.save
        flash[:notice] = 'Sivu luotu.'
        format.html { redirect_to(pages_url) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])
    @page.author_id = current_user.id
    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Sivun tiedot päivitetty.'
        format.html { redirect_to(pages_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(pages_url) }
      format.xml  { head :ok }
    end
  end


  def set_default
    @cfg = Configuration.find_or_create_by_name("default_page")
    @cfg.value = params[:default_page]
    if @cfg.save
      flash[:notice] = "Oletussivu tallennettu"
    else
      flash[:error] = "Oletussivua ei saatu tallennettua"
    end
    redirect_to(pages_url)
  end

  def menu
     @pages = Page.find(:all, :order => :menu_order)
   end

  def order
    pages = Page.find(:all, :order => :menu_order)
    pages.each do |p|
      p.update_attribute( :menu_order, params[:pages].index(p.menu_order.to_s) )
    end
    @pages = pages.sort { |a,b| a.menu_order <=> b.menu_order }
    render :update do |page|
      page.replace 'pages',
      render( :partial => "menu_list", :object => @pages )
    end
  end
end
