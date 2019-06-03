class AddUserIdToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :user_id, :integer
  end
end
