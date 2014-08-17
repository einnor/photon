require 'test_helper'

class MessageManagersControllerTest < ActionController::TestCase
  setup do
    @message_manager = message_managers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:message_managers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message_manager" do
    assert_difference('MessageManager.count') do
      post :create, message_manager: { chama_id: @message_manager.chama_id, sms_balance: @message_manager.sms_balance }
    end

    assert_redirected_to message_manager_path(assigns(:message_manager))
  end

  test "should show message_manager" do
    get :show, id: @message_manager
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @message_manager
    assert_response :success
  end

  test "should update message_manager" do
    patch :update, id: @message_manager, message_manager: { chama_id: @message_manager.chama_id, sms_balance: @message_manager.sms_balance }
    assert_redirected_to message_manager_path(assigns(:message_manager))
  end

  test "should destroy message_manager" do
    assert_difference('MessageManager.count', -1) do
      delete :destroy, id: @message_manager
    end

    assert_redirected_to message_managers_path
  end
end
