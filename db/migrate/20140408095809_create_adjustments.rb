class CreateAdjustments < ActiveRecord::Migration
  def self.up
    create_table :adjustments do |t|
      t.integer :player_id 
      t.integer :challenge_id 
      t.integer :point 
      t.string :reason 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
    add_index :adjustments, :player_id
    add_index :adjustments, :challenge_id
  end
  
  def self.down
    drop_table :adjustments
  end
end
