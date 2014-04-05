json.array!(@posts) do |post|
  json.extract! post, :id, :title, :body, :public_scope
  json.url post_url(post, format: :json)
end
