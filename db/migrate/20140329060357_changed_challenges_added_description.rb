class ChangedChallengesAddedDescription < ActiveRecord::Migration
  def self.up
    add_column :challenges, :description, :string
  end
  
  def self.down
    remove_column :challenges, :description
  end
end
