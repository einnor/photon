json.array!(@remittances) do |remittance|
  json.extract! remittance, :id, :amount, :remittance_type, :member_id
  json.url remittance_url(remittance, format: :json)
end
