json.array!(@settings) do |setting|
  json.extract! setting, :id, :remittance_deadline, :warning_days_before_deadline, :remittance_reminder_sms, :penalty_reminder_sms, :penalty_type, :penalty_amount, :penalty_repay_periods_in_days, :chama_id
  json.url setting_url(setting, format: :json)
end
