# Represents the point adjustments for players.
class Adjustment < ActiveRecord::Base
  belongs_to :player, inverse_of: :adjustments
  belongs_to :challenge, inverse_of: :adjustments

  validates_associated :player
  validates_associated :challenge

  structure do
    point  100, validates: :presence, numericality: { only_integer: true }
    reason 'First break!'

    timestamps
  end
end

