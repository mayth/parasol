# Represents a challenge.
#
# @!attribute [r] point
#   Gets the maximum points for this challenge.
#   @return [Number]
#
# @!attribute [r] opened?
#   Gets whether the challenge is opened or not.
class Challenge < ActiveRecord::Base
  has_many :answers, dependent: :destroy, inverse_of: :challenge
  has_many :flags, dependent: :destroy, inverse_of: :challenge
  has_many :adjustments, dependent: :delete_all, inverse_of: :challenge

  validates_associated :flags
  validates_presence_of :flags

  accepts_nested_attributes_for :flags, allow_destroy: true

  structure do
    name        'Parasol Star Memories', validates: :presence
    genre       'binary', validates: :presence
    description "Here is the description!\n" * 2, validates: :presence
    opened_at   Time.new(2014, 3, 18, 9, 0, 0, '+09:00')
    timestamps
  end

  def point
    flags.sum(:point)
  end

  def opened?
    opened_at.present? && opened_at <= Time.zone.now
  end

  # Opens the challenge.
  #
  # @return [Time] Opened time
  def open!(time = nil)
    unless self[:opened_at]
      current = Time.zone.now
      t = (time || current)
      t = current if t < current
      self[:opened_at] = t
      save!
    end
    self[:opened_at]
  end

  # Closes the challenge.
  #
  # @return [void]
  def close!
    self[:opened_at] = nil
    save!
  end

  def first_break
    answers.valid.order(:created_at).first
  end

  # Gets all genres.
  #
  # @return [Set<String>]
  scope :genres, -> { pluck(:genre).uniq }

  # Gets all opened challenges.
  #
  # @return [Set<Challenge>]
  scope :opened, (lambda do
    where(
      arel_table[:opened_at].not_eq(nil)
      .and(arel_table[:opened_at].lteq(Time.zone.now))
    )
  end)
end
