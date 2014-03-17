class CreateFlags < ActiveRecord::Migration
  def self.up
    create_table :flags do |t|
      t.integer :challenge_id 
      t.integer :point 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
    add_index :flags, :challenge_id
  end
  
  def self.down
    drop_table :flags
  end
end
