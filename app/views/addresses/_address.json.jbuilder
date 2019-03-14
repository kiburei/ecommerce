json.extract! address, :id, :country, :physical_address, :email, :phone_number, :created_at, :updated_at
json.url address_url(address, format: :json)
