class ChangedAnswersAddedIsCorrect < ActiveRecord::Migration
  def self.up
    add_column :answers, :is_correct, :boolean
  end
  
  def self.down
    remove_column :answers, :is_correct
  end
end
