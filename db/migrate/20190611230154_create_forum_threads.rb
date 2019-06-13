class CreateForumThreads < ActiveRecord::Migration[5.2]
  def change
    create_table :forum_threads do |t|
      t.integer :user_id
      t.text :subject
      t.text :description
      t.timestamps
    end
  end
end
