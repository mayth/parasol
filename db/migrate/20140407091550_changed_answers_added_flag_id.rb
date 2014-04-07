class ChangedAnswersAddedFlagId < ActiveRecord::Migration
  def self.up
    add_column :answers, :flag_id, :integer
    add_index :answers, :flag_id
  end
  
  def self.down
    remove_column :answers, :flag_id
  end
end
