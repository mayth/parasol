# Represents CTF players.
#
# @!attribute [r] point
#   Gets the current point.
#   @return [Number]
#
# @!attribute [r] flag_point
#   Gets the current point by submitting flags.
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
  # @return [Answer, nil]
  #   +Answer+ object if successfully submitted (no matter is it correct);
  #   otherwise, +nil+.
  def submit(challenge, flag)
    ans = answers.build(challenge: challenge, answer: flag)
    if ans.save
      adjust_first_break_point(challenge, ans) if ans.valid_answer?
      ans
    else
      nil
    end
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

  def flag_point
    captured_flags.sum(:point)
  end

  def point
    flag_point + adjustment_point
  end

  def last_submission(valid_only: false)
    (valid_only ? answers.merge(Answer.valid) : answers)
      .order(created_at: :desc).first
  end

  private

  # Adjusts the player's point by first break point.
  #
  # @param challenge [Challenge] An answered challenge.
  # @param ans [Answer] An answer object.
  # @return [Integer] Adjusted point.
  def adjust_first_break_point(challenge, ans)
    bonus = get_first_break_point(challenge, ans)
    unless bonus.zero?
      adjust!(
        bonus,
        reason: 'First break!',
        challenge: challenge
      )
    end
    bonus
  end

  # Gets the adjustment by the first break point.
  #
  # @param challenge [Challenge] An answered challenge.
  # @param ans [Answer] An answer object.
  # @return [Integer] A point for adjustment.
  def get_first_break_point(challenge, ans)
    setting =
      ApplicationController.helpers.first_break_point_setting
    answers = challenge.answers.valid.where(flag: ans.flag)
    if setting.any? && answers.count <= setting.count
      (setting[answers.count - 1] * ans.flag.point).to_i
    else
      0
    end
  end
end
