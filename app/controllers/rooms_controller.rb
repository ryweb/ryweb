class RoomsController < ApplicationController
  # GET /rooms
  # GET /rooms.xml
  def index
    @rooms = Room.find(:all).sort{|a,b| a.name.upcase <=> b.name.upcase}	 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rooms }
    end
  end

  # GET /rooms/1
  # GET /rooms/1.xml
  def show
    @room = Room.find(params[:id])

    respond_to do |format|
      format.html {  redirect_to(rooms_url(:id => @room)) }
      format.xml  { render :xml => @room }
    end
  end

  # GET /rooms/new
  # GET /rooms/new.xml
  def new
    @room = Room.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @room }
    end
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])
  end

  # POST /rooms
  # POST /rooms.xml
  def create
    @room = Room.new(params[:room])

    respond_to do |format|
      if @room.save
        flash[:notice] = 'Uusi tila lis&auml;tty luetteloon.'
        format.html {  redirect_to(rooms_url(:id => @room)) }
        format.xml  { render :xml => @room, :status => :created, :location => @room }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @room.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.xml
  def update
    @room = Room.find(params[:id])

    respond_to do |format|
      if @room.update_attributes(params[:room])
        flash[:notice] = 'Tilaa muokattu.'
        format.html { redirect_to(rooms_url) }
        format.xml  { head :ok }
      else
        flash[:notice] = 'Tilaa ei voitu muokata.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @room.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /rooms/1
  # DELETE /rooms/1.xml
  def destroy
    @room = Room.find(params[:id])
    @room.destroy     

    respond_to do |format|
      format.html { redirect_to(rooms_url) }
      format.xml  { head :ok }
    end
  end
end
        
