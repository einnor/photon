json.array!(@message_managers) do |message_manager|
  json.extract! message_manager, :id, :sms_balance, :chama_id
  json.url message_manager_url(message_manager, format: :json)
end
