require 'test_helper'

class AsLabelsControllerTest < ActionController::TestCase
  setup do
    @as_label = as_labels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:as_labels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create as_label" do
    assert_difference('AsLabel.count') do
      post :create, :as_label => @as_label.attributes
    end

    assert_redirected_to as_label_path(assigns(:as_label))
  end

  test "should show as_label" do
    get :show, :id => @as_label.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @as_label.to_param
    assert_response :success
  end

  test "should update as_label" do
    put :update, :id => @as_label.to_param, :as_label => @as_label.attributes
    assert_redirected_to as_label_path(assigns(:as_label))
  end

  test "should destroy as_label" do
    assert_difference('AsLabel.count', -1) do
      delete :destroy, :id => @as_label.to_param
    end

    assert_redirected_to as_labels_path
  end
end
