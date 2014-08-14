require 'test_helper'

class PenaltiesControllerTest < ActionController::TestCase
  setup do
    @penalty = penalties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:penalties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create penalty" do
    assert_difference('Penalty.count') do
      post :create, penalty: { amount: @penalty.amount, due_date: @penalty.due_date, member_id: @penalty.member_id, penalty_status: @penalty.penalty_status, penalty_type: @penalty.penalty_type }
    end

    assert_redirected_to penalty_path(assigns(:penalty))
  end

  test "should show penalty" do
    get :show, id: @penalty
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @penalty
    assert_response :success
  end

  test "should update penalty" do
    patch :update, id: @penalty, penalty: { amount: @penalty.amount, due_date: @penalty.due_date, member_id: @penalty.member_id, penalty_status: @penalty.penalty_status, penalty_type: @penalty.penalty_type }
    assert_redirected_to penalty_path(assigns(:penalty))
  end

  test "should destroy penalty" do
    assert_difference('Penalty.count', -1) do
      delete :destroy, id: @penalty
    end

    assert_redirected_to penalties_path
  end
end
