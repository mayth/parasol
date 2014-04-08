# Represents the point adjustments for players.
class Adjustment < ActiveRecord::Base
  belongs_to :player, inverse_of: :adjustments
  belongs_to :challenge, inverse_of: :adjustments

  structure do
    point  100
    reason 'First break!'

    timestamps
  end
end

