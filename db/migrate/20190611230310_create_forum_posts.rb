class CreateForumPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :forum_posts do |t|
      t.integer :user_id
      t.integer :commentable_id
      t.string :commentable_type 
      t.text :body
      t.timestamps
    end
  end
end
