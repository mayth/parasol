json.array!(@adjustments) do |adjustment|
  json.extract! adjustment, :id
  json.url admin_adjustment_url(adjustment, format: :json)
end
