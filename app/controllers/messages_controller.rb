class MessagesController < ApplicationController
   before_filter :login_required

  # GET /messages
  # GET /messages.xml
  def index

    @messages = Message.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new
	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
       
      end
     
    
     end

    

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save
        flash[:notice] = 'Viesti luotu.'
	if @message.receivers == 1
		@Users = User.find(:all, :conditions => ["user_level != ?", 10])
		@recipients = Array.new
		     
		@Users.each do|user|
		  @recipients.push(user.email)
		end
		      
		Emailer.deliver_contact(@recipients, 'RY_Tiedotus',
					@message.name,
					@message.valid_from,
					@message.content )
		return if request.xhr?
		flash[:notice] = 'Sähköposti lähetetty osoitteisiin<br />'+@recipients.inspect
	end

        format.html { redirect_to(messages_url) }
        format.xml  { render :xml => @message, :status => :created, :location => @message }

      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Viesti luotu.'

	if @message.receivers == 1
		#@Users = User.find(:all)
		@Users = User.find(:all, :conditions => ["user_level != ?", 10])
		@recipients = Array.new
		     
		@Users.each do|user|
		  @recipients.push(user.email)
		end
		      
		Emailer.deliver_contact(@recipients, 'RY_Tiedotus_Muutos',
					@message.name,
					@message.valid_from,
					@message.content )
		return if request.xhr?
		flash[:notice] = 'Sähköposti lähetetty osoitteisiin<br />'+@recipients.inspect
	end

        format.html { redirect_to(messages_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message= Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
end
