json.array!(@withdrawals) do |withdrawal|
  json.extract! withdrawal, :id, :amount, :description, :member_id
  json.url withdrawal_url(withdrawal, format: :json)
end
