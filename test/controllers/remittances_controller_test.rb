require 'test_helper'

class RemittancesControllerTest < ActionController::TestCase
  setup do
    @remittance = remittances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:remittances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create remittance" do
    assert_difference('Remittance.count') do
      post :create, remittance: { amount: @remittance.amount, member_id: @remittance.member_id, remittance_type: @remittance.remittance_type }
    end

    assert_redirected_to remittance_path(assigns(:remittance))
  end

  test "should show remittance" do
    get :show, id: @remittance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @remittance
    assert_response :success
  end

  test "should update remittance" do
    patch :update, id: @remittance, remittance: { amount: @remittance.amount, member_id: @remittance.member_id, remittance_type: @remittance.remittance_type }
    assert_redirected_to remittance_path(assigns(:remittance))
  end

  test "should destroy remittance" do
    assert_difference('Remittance.count', -1) do
      delete :destroy, id: @remittance
    end

    assert_redirected_to remittances_path
  end
end
