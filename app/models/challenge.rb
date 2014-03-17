# Represents a challenge.
# @!attribute [r] point
#   Gets the maximum points for this challenge.
#   @return [Number]
# @!attribute [r] opened?
#   Gets whether the challenge is opened or not.
# @!scope class
# @!attribute [r] genres
#   Gets the all genres.
#   @return [Array<String>]
class Challenge < ActiveRecord::Base
  has_many :answers, dependent: :destroy, inverse_of: :challenge
  has_many :flags, dependent: :destroy, inverse_of: :challenge

  validates_associated :flags
  validates_presence_of :flags

  structure do
    name       'Parasol Star Memories', validates: :presence
    genre      'binary', validates: :presence
    opened_at  Time.new(2014, 3, 18, 9, 0, 0, '+09:00')
    timestamps
  end

  def point
    flags.pluck(:point).inject(:+)
  end

  def opened?
    opened_at.present?
  end

  # Opens the challenge.
  #
  # @return [Time] Opened time
  def open!
    self[:opened_at] ||= Time.now
  end

  # Closes the challenge.
  #
  # @return [void]
  def close!
    self[:opened_at] = nil
  end

  def self.genres
    Challenge.pluck(:genre).uniq
  end
end
