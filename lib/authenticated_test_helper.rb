module AuthenticatedTestHelper
  # Sets the current use in the session from the use fixtures.
  def login_as(use)
    @request.session[:use_id] = use ? uses(use).id : nil
  end

  def authorize_as(use)
    @request.env["HTTP_AUTHORIZATION"] = use ? ActionController::HttpAuthentication::Basic.encode_credentials(uses(use).login, 'monkey') : nil
  end
  
end
