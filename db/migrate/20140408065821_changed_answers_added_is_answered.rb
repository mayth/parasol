class ChangedAnswersAddedIsAnswered < ActiveRecord::Migration
  def self.up
    add_column :answers, :is_answered, :boolean
  end
  
  def self.down
    remove_column :answers, :is_answered
  end
end
