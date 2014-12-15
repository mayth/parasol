json.array!(@accounts) do |account|
  json.extract! account, :id, :email, :created_at
  json.url admin_account_url(account, format: :json)
end
