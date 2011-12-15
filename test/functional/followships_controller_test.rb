require 'test_helper'

class FollowshipsControllerTest < ActionController::TestCase
  setup do
    @followship = followships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:followships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create followship" do
    assert_difference('Followship.count') do
      post :create, :followship => @followship.attributes
    end

    assert_redirected_to followship_path(assigns(:followship))
  end

  test "should show followship" do
    get :show, :id => @followship.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @followship.to_param
    assert_response :success
  end

  test "should update followship" do
    put :update, :id => @followship.to_param, :followship => @followship.attributes
    assert_redirected_to followship_path(assigns(:followship))
  end

  test "should destroy followship" do
    assert_difference('Followship.count', -1) do
      delete :destroy, :id => @followship.to_param
    end

    assert_redirected_to followships_path
  end
end
