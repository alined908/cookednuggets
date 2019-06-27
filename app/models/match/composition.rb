class Composition < ApplicationRecord
  belongs_to :match
  serialize :player_roster, Array
  serialize :hero_roster, Array
  validates :roundtype, presence: true
  validates :duration, presence: true
  validates :hero_roster, presence: true
  validates :player_roster, presence: true

  def self.import(file, match)
    CSV.foreach(file.path, :headers => [:row_id, :date, :map, :team, :roundname, :composition, :duration]).with_index do |row, index|
      next if index == 0
      comp = row[:composition][1...-1].gsub("'", "").gsub(" ", "").split(",").map(&:downcase)
      roster = row[:team][1...-1].gsub("'","").gsub(" ", "").split(",").map(&:downcase)
      Composition.create(match_id: match.id, player_roster: roster, hero_roster: comp, roundtype: row[:roundname], duration: row[:duration])
    end

  end
end
