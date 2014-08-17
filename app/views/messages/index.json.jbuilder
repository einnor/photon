json.array!(@messages) do |message|
  json.extract! message, :id, :body, :recepient, :message_manager_id
  json.url message_url(message, format: :json)
end
