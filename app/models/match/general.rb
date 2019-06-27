class General < ApplicationRecord
  belongs_to :match
  serialize :ttcu, Array
  serialize :ttuu, Array
  validates :player, presence: true
  validates :hero, presence: true
  validates :kill, presence: true
  validates :death, presence: true
  validates :ttcu, presence: true
  validates :ttuu, presence: true
  validates :fight_total, presence: true
  validates :fight_win, presence: true
  validates :fight_lose, presence: true
  validates :first_kill, presence: true
  validates :first_death, presence: true

  def self.import(file, match)
    CSV.foreach(file.path, :headers => [:row_id, :date, :map, :name, :hero, :kill, :death, :ttcu, :ttuu, :ft, :fw, :fl, :fk, :fd]).with_index do |row, index|
      next if index == 0
      ttcu = row[:ttcu][1...-1].split(',').map(&:to_i)
      ttuu = row[:ttuu][1...-1].split(',').map(&:to_i)
      General.create(match_id: match.id, player: row[:name], hero: row[:hero], kill: row[:kill], death: row[:death], ttcu: ttcu, ttuu: ttuu, fight_total: row[:ft], fight_win: row[:fw], fight_lose: row[:fl], first_kill: row[:fk], first_death: row[:fd])
    end
  end
end
