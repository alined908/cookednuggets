class CreateFights < ActiveRecord::Migration[5.2]
  def change
    create_table :fights do |t|
      t.string :roundtype
      t.integer :duration
      t.string :left_players
      t.string :left_heroes
      t.string :right_players
      t.string :right_heroes
      t.string :winner
      t.string :first_blood
      t.integer :left_kill_num
      t.integer :right_kill_num
      t.integer :left_ults_used
      t.integer :right_ults_used
      t.string :left_ult_sequence
      t.string :right_ult_sequence
      t.string :total_kill_sequence
      t.string :total_death_sequence
      t.references :match
      t.timestamps
    end
  end
end
