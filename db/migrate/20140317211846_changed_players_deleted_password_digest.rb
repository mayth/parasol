class ChangedPlayersDeletedPasswordDigest < ActiveRecord::Migration
  def self.up
    remove_column :players, :password_digest
  end
  
  def self.down
    add_column :players, :password_digest, :string, :limit=>255, :default=>nil
  end
end
