class UsersController < ApplicationController
   before_filter :login_required

  def index
    @user = self.current_user
  end
  
    def list
    @users = User.find(:all)

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
    @user = User.find(params[:id])
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])  

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @customer }
    end
    
  end
  
  def create
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      @user.update_attribute(:customer_id,current_user.customer_id)

      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session

      redirect_to(user_url (:id => @user))
      flash[:notice] = "Uusi käyttäjä lisätty onnistuneesti."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
    # PUT /customers/1
    def update
    @user = User.find(params[:id])

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

end
