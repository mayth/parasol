# Represents a submitted answer.
#
# @!attribute [r] correct?
#   Whether the answer is correct or not.
#   @return [Boolean]
#
# @!attribute [r] is_correct
#   (see #correct?)
#   @return (see #correct?)
#
# @!attribute [r] answered?
#   Whether already answered or not.
#   @return [Boolean, nil]
#     +true+ if the player answered for the same challenge with the same flag;
#     otherwise, +false+.
#     If the submitted answer is wrong, returns +nil+.
#
# @!attribute [r] is_answered
#   (see #answered?)
#   @return (see #answered?)
#
# @!attribute [r] flag
#   Gets the flag.
#   @return [Flag, nil] +Flag+ if the answer is correct; otherwise, +nil+.
#   @note
#     The player can get the flag point only if +answered?+ is +false+ and
#     +correct?+ is +true+. Cannot determine it with this returns the flag.
class Answer < ActiveRecord::Base
  belongs_to :player, inverse_of: :answers
  belongs_to :challenge, inverse_of: :answers
  belongs_to :flag, inverse_of: :answers

  validates_associated :player
  validates_presence_of :player
  validates_associated :challenge
  validates_presence_of :challenge
  validates_associated :flag

  before_save :check_correct?
  before_save :check_answered?

  structure do
    answer      'FLAG_123456'
    is_correct  true
    is_answered false
    timestamps
  end

  # rubocop:disable PredicateName

  #
  def is_correct
    self[:is_correct]
  end

  def is_answered
    self[:is_answered]
  end

  # rubocop:enable PredicateName

  alias_attribute :correct?, :is_correct
  alias_attribute :answered?, :is_answered

  def valid_answer?
    correct? && !answered?
  end

  scope :valid, -> { where(is_correct: true, is_answered: false) }

  private

  # rubocop:disable PredicateName

  # Make some attributes private.

  def is_correct=(value)
    self[:is_correct] = value
  end

  def is_answered=(value)
    self[:is_answered] = value
  end

  # rubocop:enable PredicateName

  # Check the answer.
  def check_correct?
    self.flag = challenge.flags.select { |f| /\A#{f.flag}\z/ =~ answer }.first
    self.is_correct = flag.present?
    true
  end

  def check_answered?
    self.is_answered =
      if flag
        p = player.answers
          .where(challenge: challenge, flag: flag, is_correct: true)
          .any?
        t = player.team.answers
          .where(challenge: challenge, flag: flag, is_correct: true)
          .any?
        p || t
      else
        nil
      end
    true
  end
end
