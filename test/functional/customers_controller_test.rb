require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post :create, :customer => { }
    end

    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should show customer" do
    get :show, :id => customers(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => customers(:one).id
    assert_response :success
  end

  test "should update customer" do
    put :update, :id => customers(:one).id, :customer => { }
    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete :destroy, :id => customers(:one).id
    end

    assert_redirected_to customers_path
  end
end
