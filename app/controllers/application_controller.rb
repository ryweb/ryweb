# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '7eb6de9daa0a9cefae362240888108a9'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  before_filter :set_current_customer

  private

  def set_current_customer
    if params[:customer] == 'admin'
      Customer.current = nil
    else
      Customer.current = params[:customer] 
    end
    unless current_user.nil?
      if current_user.customer_id != Customer.current_id
        unless current_user.superuser?
          access_denied
        end
      end
    end
  end

end
