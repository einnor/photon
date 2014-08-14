json.array!(@penalty_repayments) do |penalty_repayment|
  json.extract! penalty_repayment, :id, :amount, :penalty_id
  json.url penalty_repayment_url(penalty_repayment, format: :json)
end
