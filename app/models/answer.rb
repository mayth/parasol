# Represents a submitted answer.
#
# @!attribute [r] correct?
#   Whether the answer is correct or not.
#   @return [Boolean]
# @!attribute [r] flag
#   Gets the flag.
#   @return [Flag, nil] +Flag+ if the answer is correct; otherwise, +nil+.
class Answer < ActiveRecord::Base
  belongs_to :player, inverse_of: :answers
  belongs_to :challenge, inverse_of: :answers
  belongs_to :flag, inverse_of: :answers

  validates_associated :player
  validates_presence_of :player
  validates_associated :challenge
  validates_presence_of :challenge
  validates_associated :flag

  before_save :check

  structure do
    answer      'FLAG_123456'
    is_correct  true
    timestamps
  end

  def correct?
    is_correct
  end

  private
  def is_correct
    self[:is_correct]
  end

  def is_correct=(value)
    self[:is_correct] = value
  end

  # Check the answer.
  #
  # @return [Boolean] +true+ if the answer is correct; otherwise, +false+.
  def check
    self.flag = challenge.flags.select { |f| /\A#{f.flag}\z/ =~ answer }.first
    self[:is_correct] = !(flag.nil?)
    true
  end
end
