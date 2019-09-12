class CreateForumThreads < ActiveRecord::Migration[5.2]
  def change
    create_table :forum_threads do |t|
      t.integer :user_id
      t.text :subject
      t.text :description
      t.integer :comments_count, :null => false, :default => 0
      t.integer :score, :null => false, :default => 0
      t.timestamps
    end

    create_table :forum_posts do |t|
      t.integer :user_id
      t.integer :commentable_id
      t.integer :score, :null => false, :default => 0
      t.string :commentable_type
      t.integer :thread_id
      t.text :body
      t.timestamps
    end

    create_table :news do |t|
      t.string :pictures
      t.references :user
      t.boolean :featured, :null => false, :default => false
      t.string :country, :null => false, :default => "un"
      t.text :subject
      t.text :article
      t.integer :comments_count, :null => false, :default => 0
      t.timestamps
    end

    create_table :votes do |t|
      t.references :user, foreign_key: true
      t.integer :votable_id
      t.string :votable_type
      t.integer :direction
      t.timestamps
    end
  end
end
