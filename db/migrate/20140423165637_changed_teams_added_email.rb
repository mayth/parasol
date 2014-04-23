class ChangedTeamsAddedEmail < ActiveRecord::Migration
  def self.up
    add_column :teams, :email, :string
  end
  
  def self.down
    remove_column :teams, :email
  end
end
