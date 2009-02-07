require File.dirname(__FILE__) + '/../test_helper'
require 'uses_controller'

# Re-raise errors caught by the controller.
class UsesController; def rescue_action(e) raise e end; end

class UsesControllerTest < ActionController::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  # Then, you can remove it from this and the units test.
  include AuthenticatedTestHelper

  fixtures :uses

  def test_should_allow_signup
    assert_difference 'Use.count' do
      create_use
      assert_response :redirect
    end
  end

  def test_should_require_login_on_signup
    assert_no_difference 'Use.count' do
      create_use(:login => nil)
      assert assigns(:use).errors.on(:login)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference 'Use.count' do
      create_use(:password => nil)
      assert assigns(:use).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference 'Use.count' do
      create_use(:password_confirmation => nil)
      assert assigns(:use).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference 'Use.count' do
      create_use(:email => nil)
      assert assigns(:use).errors.on(:email)
      assert_response :success
    end
  end
  

  

  protected
    def create_use(options = {})
      post :create, :use => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
    end
end
