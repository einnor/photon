json.array!(@loans) do |loan|
  json.extract! loan, :id, :loan_amount_requested, :repay_period_in_months, :interest_rate_pa, :loan_interest_method, :monthly_installments, :repay_amount, :loan_status, :installment_repay_deadline, :member_id
  json.url loan_url(loan, format: :json)
end
