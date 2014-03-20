module PlayerRequestHelper
  def make_valid_player_param_hash(player)
    param = player.attributes
    param.delete 'id'
    param
  end

  def make_invalid_player_param_hash(player)
    param = make_valid_player_param_hash(player)
    param['name'] = ''
    param
  end
end

RSpec.configure do |config|
  config.include PlayerRequestHelper, type: :controller
end