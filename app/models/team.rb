require 'bcrypt'

class Team < ActiveRecord::Base
  include ::BCrypt

  has_many :players

  structure do
    name            validates: [:presence, :uniqueness]
    password_digest validates: :presence
    timestamps
  end

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    if new_password.present?
      @password = Password.create(new_password)
      self.password_digest = @password
    else
      @password = nil
      self.password_digest = nil
    end
  end

  def authenticate(password)
    if self.password == password
      self
    else
      nil
    end
  end

  def forget_password
    new_password = [*('a'..'z'), *('A'..'Z'), *('0'..'9')].sample(8).join
    self.password = new_password
    self.save!
    new_password
  end
end
