class ChangedChallengesAddedGenre < ActiveRecord::Migration
  def self.up
    add_column :challenges, :genre, :string
  end
  
  def self.down
    remove_column :challenges, :genre
  end
end
