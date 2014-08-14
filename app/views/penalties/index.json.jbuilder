json.array!(@penalties) do |penalty|
  json.extract! penalty, :id, :penalty_type, :amount, :due_date, :penalty_status, :member_id
  json.url penalty_url(penalty, format: :json)
end
