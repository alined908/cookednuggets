class CreateGenerals < ActiveRecord::Migration[5.2]
  def change
    create_table :generals do |t|
      t.string :player
      t.string :hero
      t.integer :kill
      t.integer :death
      t.string :ttcu
      t.string :ttuu
      t.integer :fight_total
      t.integer :fight_win
      t.integer :fight_lose
      t.integer :first_kill
      t.integer :first_death
      t.references :match
      t.timestamps
    end
  end
end
