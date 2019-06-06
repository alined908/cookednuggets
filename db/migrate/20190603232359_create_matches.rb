class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.date :date
      t.string :left_team
      t.string :right_team
      t.string :map
      t.references :user
      t.timestamps
    end
  end
end
