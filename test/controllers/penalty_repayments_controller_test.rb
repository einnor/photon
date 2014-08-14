require 'test_helper'

class PenaltyRepaymentsControllerTest < ActionController::TestCase
  setup do
    @penalty_repayment = penalty_repayments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:penalty_repayments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create penalty_repayment" do
    assert_difference('PenaltyRepayment.count') do
      post :create, penalty_repayment: { amount: @penalty_repayment.amount, penalty_id: @penalty_repayment.penalty_id }
    end

    assert_redirected_to penalty_repayment_path(assigns(:penalty_repayment))
  end

  test "should show penalty_repayment" do
    get :show, id: @penalty_repayment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @penalty_repayment
    assert_response :success
  end

  test "should update penalty_repayment" do
    patch :update, id: @penalty_repayment, penalty_repayment: { amount: @penalty_repayment.amount, penalty_id: @penalty_repayment.penalty_id }
    assert_redirected_to penalty_repayment_path(assigns(:penalty_repayment))
  end

  test "should destroy penalty_repayment" do
    assert_difference('PenaltyRepayment.count', -1) do
      delete :destroy, id: @penalty_repayment
    end

    assert_redirected_to penalty_repayments_path
  end
end
