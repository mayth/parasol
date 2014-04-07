class ChangedChallengesModifiedDescription < ActiveRecord::Migration
  def self.up
    change_column :challenges, :description, :text
  end
  
  def self.down
    change_column :challenges, :description, :string, :limit=>255, :default=>nil
  end
end
