# Represents a challenge.
# @!attribute [r] point
#   Gets the maximum points for this challenge.
class Challenge < ActiveRecord::Base
  has_many :answers, dependent: :destroy, inverse_of: :challenge
  has_many :flags, dependent: :destroy, inverse_of: :challenge

  validates_associated :flags
  validates_presence_of :flags

  structure do
    name       'Parasol Star Memories', validates: :presence
    genre      'binary', validates: :presence
    timestamps
  end

  def point
    flags.pluck(:point).inject(:+)
  end

  def self.genres
    Challenge.pluck(:genre).uniq
  end
end
