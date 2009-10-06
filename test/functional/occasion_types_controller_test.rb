require 'test_helper'

class OccasionTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:occasion_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create occasion_type" do
    assert_difference('OccasionType.count') do
      post :create, :occasion_type => { }
    end

    assert_redirected_to occasion_type_path(assigns(:occasion_type))
  end

  test "should show occasion_type" do
    get :show, :id => occasion_types(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => occasion_types(:one).id
    assert_response :success
  end

  test "should update occasion_type" do
    put :update, :id => occasion_types(:one).id, :occasion_type => { }
    assert_redirected_to occasion_type_path(assigns(:occasion_type))
  end

  test "should destroy occasion_type" do
    assert_difference('OccasionType.count', -1) do
      delete :destroy, :id => occasion_types(:one).id
    end

    assert_redirected_to occasion_types_path
  end
end
