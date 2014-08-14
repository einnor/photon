json.array!(@loan_repayments) do |loan_repayment|
  json.extract! loan_repayment, :id, :amount, :loan_id
  json.url loan_repayment_url(loan_repayment, format: :json)
end
