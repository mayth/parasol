class ChangedTeamsAddedSuspendedUntil < ActiveRecord::Migration
  def self.up
    add_column :teams, :suspended_until, :datetime
  end
  
  def self.down
    remove_column :teams, :suspended_until
  end
end
