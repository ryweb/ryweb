class PublicController < ApplicationController
  layout 'public'

  before_filter :set_layout
  before_filter :generate_menu

  def index
    default_page = Configuration.get_one('default_page')
    if default_page.nil?
      render :text => "Oletussivua ei ole määritetty"
      return
    end
    redirect_to(:action => 'page', :id => default_page.to_i)
  end


  def page
    @page = Page.find(params[:id])
    if @page.nil? or @page.public == 0 or @page.state != 2
      render :text => 'Virheellinen sivu'
      return
    end
    @layout = @page.layout
  end

  private
  def set_layout
    @layout = Layout.find(:first)
  end

  def generate_menu
    @mainmenu = Page.find(:all, :conditions => {:public => 1, :state => 2})
  end
  


end
