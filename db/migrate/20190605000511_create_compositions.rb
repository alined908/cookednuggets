class CreateCompositions < ActiveRecord::Migration[5.2]
  def change
    create_table :compositions do |t|
      t.string :player_roster
      t.string :hero_roster
      t.string :roundtype
      t.integer :duration
      t.references :match
      t.timestamps
    end
  end
end
