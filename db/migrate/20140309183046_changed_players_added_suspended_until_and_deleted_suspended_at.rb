class ChangedPlayersAddedSuspendedUntilAndDeletedSuspendedAt < ActiveRecord::Migration
  def self.up
    add_column :players, :suspended_until, :string
    remove_column :players, :suspended_at
  end
  
  def self.down
    add_column :players, :suspended_at, :datetime, :limit=>nil, :default=>nil
    remove_column :players, :suspended_until
  end
end
