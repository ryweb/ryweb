require 'test_helper'

class OccasionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:occasions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create occasion" do
    assert_difference('Occasion.count') do
      post :create, :occasion => { }
    end

    assert_redirected_to occasion_path(assigns(:occasion))
  end

  test "should show occasion" do
    get :show, :id => occasions(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => occasions(:one).id
    assert_response :success
  end

  test "should update occasion" do
    put :update, :id => occasions(:one).id, :occasion => { }
    assert_redirected_to occasion_path(assigns(:occasion))
  end

  test "should destroy occasion" do
    assert_difference('Occasion.count', -1) do
      delete :destroy, :id => occasions(:one).id
    end

    assert_redirected_to occasions_path
  end
end
