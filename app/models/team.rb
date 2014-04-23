require 'bcrypt'

# @!attribute password
#   A team's password
#   @return [String]
# @!attribute [r] point
#   A sum of the team members' point.
#   @return [Number]
# @!attribute [r] suspended?
#   Whether the team is suspended or not.
# Represents a team.
class Team < ActiveRecord::Base
  include ::BCrypt

  has_many :players, inverse_of: :team, dependent: :restrict_with_error

  structure do
    name            validates: [
      :presence,
      :uniqueness,
      format: { with: /\A[- [:word:]]+\z/ }
    ]
    email validates: [:presence, :uniqueness]
    password_digest validates: :presence
    suspended_until Time.now.tomorrow
    timestamps
  end
  has_secure_password

  def suspended?
    if self.suspended_until
      if self.suspended_until < Time.now
        resume!
        false
      else
        true
      end
    else
      false
    end
  end

  def point
    players.map { |p| p.point }.reduce(:+) || 0
  end

  def flag_point
    players.map { |p| p.flag_point }.reduce(:+) || 0
  end

  def adjustment_point
    players.map { |p| p.adjustment_point }.reduce(:+) || 0
  end

  def last_submission(valid_only: false)
    players.map { |p| p.last_submission(valid_only: valid_only) }
           .reject { |ans| ans.nil? }
           .sort_by { |ans| ans.created_at }
           .last
  end

  ### Methods

  def self.ranking
    Team.all.sort_by do |t|
      [
        -t.point,      # in descending order of the point
        -t.flag_point, # in descending order of the point by submission
        t.last_submission(valid_only: true) || Time.zone.now,
          # in ascending order of last submission date
        t.created_at   # in ascending order of team registration date
      ]
    end
  end

  # Generates a new password.
  #
  # @return [String] A new password.
  def generate_password
    [*('a'..'z'), *('A'..'Z'), *('0'..'9')].sample(8).join
  end

  # Resets the password.
  #
  # @return [String?]
  #   A new password is returned if succeeded; otherwise, +nil+.
  def forget_password!
    new_pw = generate_password
    self.password = new_pw
    self.password_confirmation = new_pw
    if save
      new_pw
    else
      nil
    end
  end

  # Suspends the team.
  #
  # @param period [Integer, Time] the period to suspend.
  #   if Integer is given, the team is suspended until `Time.now + +period+`.
  #   if Time is given, the team suspended until +period+.
  # @return [void]
  def suspend!(period = 900)
    raise ArgumentError, "`period' must not be nil." unless period
    case period
    when Integer, Float
      self.suspended_until = Time.now + period
    when Time
      self.suspended_until = period
    else
      raise TypeError, "`period' should be Integer or Time."
    end
    save!
  end

  # Resumes the team.
  #
  # @return [void]
  def resume!
    self.suspended_until = nil
    save!
  end

  # Returns whether the given player belongs to this team.
  #
  # @return [Boolean]
  #   +true+ if the given player belongs to this team; otherwise, +false+.
  def member?(player)
    players.include?(player)
  end
end
