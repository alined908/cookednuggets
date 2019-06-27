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

    create_table :compositions do |t|
      t.string :player_roster
      t.string :hero_roster
      t.string :roundtype
      t.integer :duration
      t.references :match
      t.timestamps
    end

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
