class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.integer :team_id 
      t.string :name 
      t.string :email 
      t.string :password_digest 
      t.datetime :suspended_at 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
    add_index :players, :team_id
  end
  
  def self.down
    drop_table :players
  end
end
