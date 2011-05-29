require 'test_helper'

class AsValuesControllerTest < ActionController::TestCase
  setup do
    @as_value = as_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:as_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create as_value" do
    assert_difference('AsValue.count') do
      post :create, :as_value => @as_value.attributes
    end

    assert_redirected_to as_value_path(assigns(:as_value))
  end

  test "should show as_value" do
    get :show, :id => @as_value.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @as_value.to_param
    assert_response :success
  end

  test "should update as_value" do
    put :update, :id => @as_value.to_param, :as_value => @as_value.attributes
    assert_redirected_to as_value_path(assigns(:as_value))
  end

  test "should destroy as_value" do
    assert_difference('AsValue.count', -1) do
      delete :destroy, :id => @as_value.to_param
    end

    assert_redirected_to as_values_path
  end
end
