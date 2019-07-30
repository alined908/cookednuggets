class CreateForumThreads < ActiveRecord::Migration[5.2]
  def change
    create_table :forum_threads do |t|
      t.integer :user_id
      t.text :subject
      t.text :description
      t.integer :comments_count, :null => false, :default => 0
      t.timestamps
    end

    create_table :forum_posts do |t|
      t.integer :user_id
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :thread_id
      t.text :body
      t.timestamps
    end
  end
end
