module TeamRequestHelper
  def make_valid_team_param_hash(team)
    param = team.attributes
    %w(id created_at updated_at password_digest).each do |k|
      param.delete k
    end
    yield param if block_given?
    param
  end

  def make_invalid_team_param_hash(team)
    param = make_valid_team_param_hash(team)
    param[:name] = ''
    param
  end
end

RSpec.configure do |config|
  config.include TeamRequestHelper, type: :controller
end