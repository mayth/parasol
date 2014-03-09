# Represents CTF players.
class Player < ActiveRecord::Base
  has_secure_password

  has_many :answers
  belongs_to :team

  structure do
    name        'Kogasa Tatara',      validates: :presence
    email       'kogasa@example.com', validates: [:presence, :uniqueness]
    password_digest                   validates: :presence
    timestamps
  end
end
