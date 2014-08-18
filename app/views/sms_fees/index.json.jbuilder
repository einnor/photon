json.array!(@sms_fees) do |sms_fee|
  json.extract! sms_fee, :id, :package, :amount, :txn_status, :pesapal_txn_tracking_id, :pesapal_merchant_reference, :chama_id
  json.url sms_fee_url(sms_fee, format: :json)
end
