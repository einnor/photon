require 'test_helper'

class LoansControllerTest < ActionController::TestCase
  setup do
    @loan = loans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:loans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create loan" do
    assert_difference('Loan.count') do
      post :create, loan: { installment_repay_deadline: @loan.installment_repay_deadline, interest_rate_pa: @loan.interest_rate_pa, loan_amount_requested: @loan.loan_amount_requested, loan_interest_method: @loan.loan_interest_method, loan_status: @loan.loan_status, member_id: @loan.member_id, monthly_installments: @loan.monthly_installments, repay_amount: @loan.repay_amount, repay_period_in_months: @loan.repay_period_in_months }
    end

    assert_redirected_to loan_path(assigns(:loan))
  end

  test "should show loan" do
    get :show, id: @loan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @loan
    assert_response :success
  end

  test "should update loan" do
    patch :update, id: @loan, loan: { installment_repay_deadline: @loan.installment_repay_deadline, interest_rate_pa: @loan.interest_rate_pa, loan_amount_requested: @loan.loan_amount_requested, loan_interest_method: @loan.loan_interest_method, loan_status: @loan.loan_status, member_id: @loan.member_id, monthly_installments: @loan.monthly_installments, repay_amount: @loan.repay_amount, repay_period_in_months: @loan.repay_period_in_months }
    assert_redirected_to loan_path(assigns(:loan))
  end

  test "should destroy loan" do
    assert_difference('Loan.count', -1) do
      delete :destroy, id: @loan
    end

    assert_redirected_to loans_path
  end
end
