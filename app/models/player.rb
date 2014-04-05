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
    answer.save ? answer.flag : nil
  end

  # Determines whether this player belongs to the given team or not.
  #
  # @return [Boolean]
  #   +true+ if this player belongs to the given team; otherwise, +false+.
  def member_of?(team)
    self.team == team
  end

  def point
    points = answers.select{|ans| ans.correct?}.map{|ans| ans.flag.point}
    points.present? ? points.inject(:+) : 0
  end
end
