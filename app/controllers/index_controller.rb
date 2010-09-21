class IndexController < ApplicationController
  
  # GET /customers
  # GET /customers.xml
  def index
    @customers = Customer.find(:all)

    respond_to do |format|
      format.html { render :layout => false }# index.html.erb
      format.xml  { render :xml => @customers }
    end
  end

  # GET /customers/1
  # GET /customers/1.xml
  def show
    @customer = Customer.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false }# show.html.erb
      format.xml  { render :xml => @customer }
    end
  end

end
