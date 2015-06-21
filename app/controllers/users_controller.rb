class UsersController < ApplicationController
  before_filter :login_required
  filter_resource_access :attribute_check => true
  filter_access_to :list, :require => :manage

  def index
    @user = self.current_user

    # Näytetään etusivulla käyttäjän lähettämät palautteet
    if current_user.superuser?
     @feedbacks = Feedback.find(:all, :order => "created_at DESC")
    else
     @feedbacks = Feedback.find_all_by_user_id (@user.id, :order => "created_at DESC")
    end

    #Näytetään etusivulla muuttuneet tapahtumat
    @modified_occasions = Occasion.find(:all, :joins => :occasion_type, :conditions => ["start_time >= ? AND (state = ? OR state =?) AND inform_changes = ? ", Time.now.beginning_of_day, 20,30, true], :order => 'start_time ')
  end
  
  def list
    @users = User.with_permissions_to(:index).find(:all)

    respond_to do |format|
      format.html # list.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  # render new.rhtml
  def new
    @user = User.new
  end
  
  # GET /users/1/edit
  def edit
    @user = User.with_permissions_to(:edit).find(params[:id])
  end

  # GET /users/1
  def show
    @user = User.with_permissions_to(:show).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @customer }
    end
    
  end
  
  def create
    @user = User.new(params[:user])
        
    success = @user && @user.save
    if success && @user.errors.empty?

      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      
      redirect_to(user_url(:id => @user))
      flash[:notice] = "Uusi käyttäjä lisätty onnistuneesti."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
    # PUT /customers/1
    def update
    @user = User.with_permissions_to(:update).find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])

        flash[:notice] = "Käyttäjän #{@user.login} tiedot päivitetty."
        format.html { redirect_to(user_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.xml
  def destroy
    @user = User.with_permissions_to(:destroy).find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(:action => "list") }
      format.xml  { head :ok }
    end
  end
end