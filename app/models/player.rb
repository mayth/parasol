# Represents CTF players.
#
# @!attribute [r] point
#   Gets the current point.
#   @return [Number]
#
# @!attribute [r] adjustment_point
#   Gets the current adjustment point.
#   @return [Number]
#
# @!attribute name
#   Gets or sets the player's name.
#   It should not be blank.
#   @return [String]
#
# @!attribute email
#   Gets or sets the player's mail address.
#   It should not be blank.
#   @return [String]
class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :answers, dependent: :destroy, inverse_of: :player
  has_many :adjustments, dependent: :delete_all, inverse_of: :player
  belongs_to :team, inverse_of: :players

  validates_associated :team
  validates_presence_of :team
  validates_presence_of :name
  validates :email, presence: true, uniqueness: true

  # Submits the answer.
  #
  # @param challenge [Challenge] A challenge to submit.
  # @param flag [String] A flag.
  # @return [Flag, nil]
  #   +Flag+ if the flag is correct; otherwise, +nil+.
  #   When something wrong while submitting answer, returns +nil+.
  def submit(challenge, flag)
    answer = answers.create(challenge: challenge, answer: flag)
    answer.flag
  end

  # Determines whether this player belongs to the given team or not.
  #
  # @return [Boolean]
  #   +true+ if this player belongs to the given team; otherwise, +false+.
  def member_of?(team)
    self.team == team
  end

  # Gets the flags that are already 'captured'.
  #
  # @return [Set<Flag>] Captured flags.
  def captured_flags
    flags_table = Flag.arel_table
    answers_table = Answer.arel_table
    sub_query =
      flags_table[:id].in(answers_table
        .where(answers_table[:is_correct].eq(true)
          .and(answers_table[:is_answered].eq(false))
          .and(answers_table[:player_id].eq(id)))
        .project(answers_table[:flag_id])
      )
    Flag.where(sub_query)
  end

  # Adjusts the point of this player.
  #
  # @param point [Integer] A point for adjustment.
  # @param reason [String] A reason of adjustment.
  # @param challenge [Challenge] A challenge related to the adjustment.
  # @return [Adjustment, nil]
  #   returns an adjustment data if succeeded;
  #   otherwise (for example, +point+ is not an integer), +nil+.
  def adjust!(point, reason: nil, challenge: nil)
    case point
    when Integer
      pt = point
    when String
      return nil unless point =~ /\A[+-]?\d+\z/
      pt = Integer(point)
    else
      return nil
    end
    adjustments.create(point: pt, reason: reason, challenge: challenge)
  end

  def adjustment_point
    adjustments.sum(:point)
  end

  def point
    captured_flags.sum(:point) + adjustment_point
  end

  def last_submission(valid_only: false)
    (valid_only ? answers.merge(Answer.valid) : answers)
      .order(created_at: :desc).first
  end
end
