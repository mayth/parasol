class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.integer :player_id 
      t.integer :challenge_id 
      t.string :answer 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
    add_index :answers, :player_id
    add_index :answers, :challenge_id
  end
  
  def self.down
    drop_table :answers
  end
end
