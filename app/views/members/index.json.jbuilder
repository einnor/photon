json.array!(@members) do |member|
  json.extract! member, :id, :name, :phone_number, :occupation, :national_id_number, :others, :chama_id
  json.url member_url(member, format: :json)
end
