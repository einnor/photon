require 'test_helper'

class SettingsControllerTest < ActionController::TestCase
  setup do
    @setting = settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create setting" do
    assert_difference('Setting.count') do
      post :create, setting: { chama_id: @setting.chama_id, penalty_amount: @setting.penalty_amount, penalty_reminder_sms: @setting.penalty_reminder_sms, penalty_repay_periods_in_days: @setting.penalty_repay_periods_in_days, penalty_type: @setting.penalty_type, remittance_deadline: @setting.remittance_deadline, remittance_reminder_sms: @setting.remittance_reminder_sms, warning_days_before_deadline: @setting.warning_days_before_deadline }
    end

    assert_redirected_to setting_path(assigns(:setting))
  end

  test "should show setting" do
    get :show, id: @setting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @setting
    assert_response :success
  end

  test "should update setting" do
    patch :update, id: @setting, setting: { chama_id: @setting.chama_id, penalty_amount: @setting.penalty_amount, penalty_reminder_sms: @setting.penalty_reminder_sms, penalty_repay_periods_in_days: @setting.penalty_repay_periods_in_days, penalty_type: @setting.penalty_type, remittance_deadline: @setting.remittance_deadline, remittance_reminder_sms: @setting.remittance_reminder_sms, warning_days_before_deadline: @setting.warning_days_before_deadline }
    assert_redirected_to setting_path(assigns(:setting))
  end

  test "should destroy setting" do
    assert_difference('Setting.count', -1) do
      delete :destroy, id: @setting
    end

    assert_redirected_to settings_path
  end
end
