require 'test_helper'

class ServiceFeesControllerTest < ActionController::TestCase
  setup do
    @service_fee = service_fees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_fees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_fee" do
    assert_difference('ServiceFee.count') do
      post :create, service_fee: { amount: @service_fee.amount, chama_id: @service_fee.chama_id, description: @service_fee.description, next_payment_due_date: @service_fee.next_payment_due_date, payment_type: @service_fee.payment_type, pesapal_merchant_reference: @service_fee.pesapal_merchant_reference, pesapal_txn_tracking_id: @service_fee.pesapal_txn_tracking_id, service_status: @service_fee.service_status, txn_status: @service_fee.txn_status }
    end

    assert_redirected_to service_fee_path(assigns(:service_fee))
  end

  test "should show service_fee" do
    get :show, id: @service_fee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_fee
    assert_response :success
  end

  test "should update service_fee" do
    patch :update, id: @service_fee, service_fee: { amount: @service_fee.amount, chama_id: @service_fee.chama_id, description: @service_fee.description, next_payment_due_date: @service_fee.next_payment_due_date, payment_type: @service_fee.payment_type, pesapal_merchant_reference: @service_fee.pesapal_merchant_reference, pesapal_txn_tracking_id: @service_fee.pesapal_txn_tracking_id, service_status: @service_fee.service_status, txn_status: @service_fee.txn_status }
    assert_redirected_to service_fee_path(assigns(:service_fee))
  end

  test "should destroy service_fee" do
    assert_difference('ServiceFee.count', -1) do
      delete :destroy, id: @service_fee
    end

    assert_redirected_to service_fees_path
  end
end
