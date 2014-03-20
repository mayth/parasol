json.array!(@challenges) do |challenge|
  json.extract! challenge, :id
  json.url admin_challenge_url(challenge, format: :json)
end
