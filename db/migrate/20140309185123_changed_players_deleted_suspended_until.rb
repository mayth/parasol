class ChangedPlayersDeletedSuspendedUntil < ActiveRecord::Migration
  def self.up
    remove_column :players, :suspended_until
  end
  
  def self.down
    add_column :players, :suspended_until, :string, :limit=>255, :default=>nil
  end
end
