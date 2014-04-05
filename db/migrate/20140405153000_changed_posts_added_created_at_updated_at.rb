class ChangedPostsAddedCreatedAtUpdatedAt < ActiveRecord::Migration
  def self.up
    add_column :posts, :created_at, :datetime
    add_column :posts, :updated_at, :datetime
  end
  
  def self.down
    remove_column :posts, :created_at
    remove_column :posts, :updated_at
  end
end
