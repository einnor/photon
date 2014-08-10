json.array!(@chamas) do |chama|
  json.extract! chama, :id, :name, :description, :type, :approx_no_of_members, :user_id
  json.url chama_url(chama, format: :json)
end
