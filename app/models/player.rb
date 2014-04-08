# Represents CTF players.
# @!attribute [r] point
#   Gets the current point.
#   @return [Number]
# @!attribute name
#   Gets or sets the player's name.
#   It should not be blank.
#   @return [String]
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

  def point
    captured_flags.sum(:point)
  end
end
