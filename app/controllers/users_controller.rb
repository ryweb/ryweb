class UsersController < ApplicationController
   before_filter :login_required

  def index
    @user = self.current_user
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
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
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
