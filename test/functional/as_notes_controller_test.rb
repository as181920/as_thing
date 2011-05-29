require 'test_helper'

class AsNotesControllerTest < ActionController::TestCase
  setup do
    @as_note = as_notes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:as_notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create as_note" do
    assert_difference('AsNote.count') do
      post :create, :as_note => @as_note.attributes
    end

    assert_redirected_to as_note_path(assigns(:as_note))
  end

  test "should show as_note" do
    get :show, :id => @as_note.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @as_note.to_param
    assert_response :success
  end

  test "should update as_note" do
    put :update, :id => @as_note.to_param, :as_note => @as_note.attributes
    assert_redirected_to as_note_path(assigns(:as_note))
  end

  test "should destroy as_note" do
    assert_difference('AsNote.count', -1) do
      delete :destroy, :id => @as_note.to_param
    end

    assert_redirected_to as_notes_path
  end
end
