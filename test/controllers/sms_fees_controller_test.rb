require 'test_helper'

class SmsFeesControllerTest < ActionController::TestCase
  setup do
    @sms_fee = sms_fees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sms_fees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sms_fee" do
    assert_difference('SmsFee.count') do
      post :create, sms_fee: { amount: @sms_fee.amount, chama_id: @sms_fee.chama_id, package: @sms_fee.package, pesapal_merchant_reference: @sms_fee.pesapal_merchant_reference, pesapal_txn_tracking_id: @sms_fee.pesapal_txn_tracking_id, txn_status: @sms_fee.txn_status }
    end

    assert_redirected_to sms_fee_path(assigns(:sms_fee))
  end

  test "should show sms_fee" do
    get :show, id: @sms_fee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sms_fee
    assert_response :success
  end

  test "should update sms_fee" do
    patch :update, id: @sms_fee, sms_fee: { amount: @sms_fee.amount, chama_id: @sms_fee.chama_id, package: @sms_fee.package, pesapal_merchant_reference: @sms_fee.pesapal_merchant_reference, pesapal_txn_tracking_id: @sms_fee.pesapal_txn_tracking_id, txn_status: @sms_fee.txn_status }
    assert_redirected_to sms_fee_path(assigns(:sms_fee))
  end

  test "should destroy sms_fee" do
    assert_difference('SmsFee.count', -1) do
      delete :destroy, id: @sms_fee
    end

    assert_redirected_to sms_fees_path
  end
end
