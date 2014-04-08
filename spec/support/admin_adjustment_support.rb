module AdminAdjustmentRequestHelper
  def make_adjustment_param_hash(adjustment)
    at = adjustment.attributes
    # any one?
    at.delete 'id'
    at.delete :id
    at
  end
end

RSpec.configure do |config|
  config.include AdminAdjustmentRequestHelper, type: :controller
end