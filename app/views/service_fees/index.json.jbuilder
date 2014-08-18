json.array!(@service_fees) do |service_fee|
  json.extract! service_fee, :id, :payment_type, :amount, :description, :next_payment_due_date, :service_status, :txn_status, :pesapal_txn_tracking_id, :pesapal_merchant_reference, :chama_id
  json.url service_fee_url(service_fee, format: :json)
end
