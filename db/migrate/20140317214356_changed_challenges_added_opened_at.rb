class ChangedChallengesAddedOpenedAt < ActiveRecord::Migration
  def self.up
    add_column :challenges, :opened_at, :datetime
  end
  
  def self.down
    remove_column :challenges, :opened_at
  end
end
