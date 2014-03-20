json.array!(@admin_players) do |admin_player|
  json.extract! admin_player, :id
  json.url admin_player_url(admin_player, format: :json)
end
