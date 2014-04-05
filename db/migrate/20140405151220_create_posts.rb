class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.text   :body
      t.string :public_scope, :inclusion=>{:in=>["player", "public"]}, :validation=>:presence 
    end
  end
  
  def self.down
    drop_table :posts
  end
end
