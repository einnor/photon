require 'test_helper'

class ChamasControllerTest < ActionController::TestCase
  setup do
    @chama = chamas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chamas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chama" do
    assert_difference('Chama.count') do
      post :create, chama: { approx_no_of_members: @chama.approx_no_of_members, description: @chama.description, name: @chama.name, type: @chama.type, user_id: @chama.user_id }
    end

    assert_redirected_to chama_path(assigns(:chama))
  end

  test "should show chama" do
    get :show, id: @chama
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chama
    assert_response :success
  end

  test "should update chama" do
    patch :update, id: @chama, chama: { approx_no_of_members: @chama.approx_no_of_members, description: @chama.description, name: @chama.name, type: @chama.type, user_id: @chama.user_id }
    assert_redirected_to chama_path(assigns(:chama))
  end

  test "should destroy chama" do
    assert_difference('Chama.count', -1) do
      delete :destroy, id: @chama
    end

    assert_redirected_to chamas_path
  end
end
