require 'test_helper'

class UiTemplatesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ui_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ui_template" do
    assert_difference('UiTemplate.count') do
      post :create, :ui_template => { }
    end

    assert_redirected_to ui_template_path(assigns(:ui_template))
  end

  test "should show ui_template" do
    get :show, :id => ui_templates(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ui_templates(:one).to_param
    assert_response :success
  end

  test "should update ui_template" do
    put :update, :id => ui_templates(:one).to_param, :ui_template => { }
    assert_redirected_to ui_template_path(assigns(:ui_template))
  end

  test "should destroy ui_template" do
    assert_difference('UiTemplate.count', -1) do
      delete :destroy, :id => ui_templates(:one).to_param
    end

    assert_redirected_to ui_templates_path
  end
end
