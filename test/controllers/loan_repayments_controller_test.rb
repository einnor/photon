require 'test_helper'

class LoanRepaymentsControllerTest < ActionController::TestCase
  setup do
    @loan_repayment = loan_repayments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:loan_repayments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create loan_repayment" do
    assert_difference('LoanRepayment.count') do
      post :create, loan_repayment: { amount: @loan_repayment.amount, loan_id: @loan_repayment.loan_id }
    end

    assert_redirected_to loan_repayment_path(assigns(:loan_repayment))
  end

  test "should show loan_repayment" do
    get :show, id: @loan_repayment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @loan_repayment
    assert_response :success
  end

  test "should update loan_repayment" do
    patch :update, id: @loan_repayment, loan_repayment: { amount: @loan_repayment.amount, loan_id: @loan_repayment.loan_id }
    assert_redirected_to loan_repayment_path(assigns(:loan_repayment))
  end

  test "should destroy loan_repayment" do
    assert_difference('LoanRepayment.count', -1) do
      delete :destroy, id: @loan_repayment
    end

    assert_redirected_to loan_repayments_path
  end
end
