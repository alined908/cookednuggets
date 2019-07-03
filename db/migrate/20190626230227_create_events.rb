class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :desc
      t.string :location
      t.string :country
      t.integer :prize
      t.date :start_date
      t.date :end_date
    end

    create_table :teams do |t|
      t.string :name
      t.string :shortname
      t.string :logo
      t.string :country
      t.string :socials
      t.string :website
    end

    create_table :eventteams, id:false do |t|
      t.belongs_to :event, index: true, foreign_key: true
      t.belongs_to :team, index: true, foreign_key: true
      t.timestamps
    end

    create_table :players do |t|
      t.string :headshot
      t.string :eng_name
      t.string :nat_name
      t.string :nicknames
      t.string :handle
      t.string :country
      t.integer :age
      t.string :roles
      t.string :socials
      t.references :team, foreign_key: true
      t.timestamps
    end

    create_table :sections do |t|
      t.references :event
      t.string :name
      t.date :start
      t.date :end
    end

    #Matches
    create_table :officials do |t|
      t.references :team1, index: true, foreign_key: {to_table: :teams}
      t.references :team2, index: true, foreign_key: {to_table: :teams}
      t.references :winner, index: true, foreign_key: {to_table: :teams}
      t.string :label
      t.string :score
      t.string :match_type
      t.datetime :start
      t.datetime :end
      t.references :section
      t.timestamps
    end

    create_table :maps do |t|
      t.references :official
      t.references :winner, index: true, foreign_key: {to_table: :teams}
      t.string :score
      t.string :map
      t.string :state
    end
  end
end
