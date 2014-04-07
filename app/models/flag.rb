# Represents a flag
# @!attribute point
#   Gets or sets the flag's point.
#   This must be non-negative value. If you attempt to set a negative-value, it has no effects.
#   @return [Number]
# @!attribute flag
#   Gets or sets the flag value.
#   @return [String]
class Flag < ActiveRecord::Base
  belongs_to :challenge, inverse_of: :flags
  has_many :answers, inverse_of: :flag

  structure do
    point       200, validates: :presence
    flag        'FLAG_kogasa', validates: :presence
    timestamps
  end

  def point=(value)
    value = Integer(value)
    self[:point] = value if value >= 0
  end
end

