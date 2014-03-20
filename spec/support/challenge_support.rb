module ChallengeRequestHelper
  def make_challenge_param_hash(challenge)
    param = challenge.attributes
    if param[:flags]
      param[:flags] = Hash[
        param[:flags].map do |f|
          at = f.attributes
          at.delete 'id'
          if f.new_record?
            [f.name, at]
          else
            [f.id, at]
          end
        end
      ]
    end
    param
  end
end

RSpec.configure do |config|
  config.include ChallengeRequestHelper, type: :controller
end