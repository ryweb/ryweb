class PublicController < ApplicationController
  layout 'public'

  before_filter :set_layout
  before_filter :generate_menu

  def index
  end


  def page
    @page = Page.find(params[:id])
  end

  private
  def set_layout
    @layout = Layout.find(:first)
  end

  def generate_menu
    @mainmenu = ['eka','toka','kolmas']
  end
  


end
