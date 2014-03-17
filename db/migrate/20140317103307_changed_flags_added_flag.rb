class ChangedFlagsAddedFlag < ActiveRecord::Migration
  def self.up
    add_column :flags, :flag, :string
  end
  
  def self.down
    remove_column :flags, :flag
  end
end
