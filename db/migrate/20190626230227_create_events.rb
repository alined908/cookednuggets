class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :shortname
      t.string :color
      t.string :desc
      t.string :location
      t.string :country, :null => false, :default => "un"
      t.integer :prize
      t.date :start_date
      t.date :end_date
      t.boolean :display_ranking, :null => false, :default => false
      t.boolean :primary_ranking, :null => false, :default => false
      t.timestamps
    end

    create_table :teams do |t|
      t.string :name
      t.string :shortname
      t.string :logo
      t.string :country, :null => false, :default => "un"
      t.string :socials
      t.string :website
      t.integer :winnings, :null => false, :default => 0
      t.integer :rating, :null => false, :default => 1500
      t.integer :streak, :null => false, :default => 0
      t.integer :games_played, :null => false, :default => 0
      t.datetime :last_played
      t.timestamps
    end

    create_table :eventteams, id:false do |t|
      t.belongs_to :event, index: true, foreign_key: true
      t.belongs_to :team, index: true, foreign_key: true
      t.timestamps
    end

    create_table :sections do |t|
      t.references :event
      t.string :name
      t.date :start
      t.date :end
      t.timestamps
    end

    #Matches
    create_table :officials do |t|
      t.references :team1, index: true, foreign_key: {to_table: :teams}
      t.references :team2, index: true, foreign_key: {to_table: :teams}
      t.references :winner, index: true, foreign_key: {to_table: :teams}
      t.integer :identifier
      t.integer :comments_count, :null => false, :default => 0
      t.integer :map_count, :null => false, :default => 5
      t.string :label
      t.string :score
      t.string :match_type
      t.datetime :start
      t.datetime :end
      t.references :section
      t.references :event
      t.string :subject
      t.timestamps
    end

    create_table :players do |t|
      t.string :headshot
      t.string :eng_name
      t.string :nat_name
      t.string :nicknames
      t.string :handle
      t.string :country, :null => false, :default => "un"
      t.date :birthday
      t.string :roles
      t.string :socials
      t.boolean :starter, :null => false, :default => false
      t.references :team, foreign_key: true
      t.integer :past_teams, array: true
      t.timestamps
    end

    create_table :maps do |t|
      t.references :official
      t.references :winner, index: true, foreign_key: {to_table: :teams}
      t.string :score
      t.string :name
      t.string :state
      t.timestamps
    end

    create_table :performances do |t|
      t.belongs_to :player, index: true, foreign_key: true
      t.belongs_to :map, index: true, foreign_key: true
      t.belongs_to :team, index: true, foreign_key: true
      t.timestamps
    end
  end
end
