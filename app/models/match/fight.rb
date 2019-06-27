class Fight < ApplicationRecord
  belongs_to :match
  serialize :left_players
  serialize :right_players
  serialize :left_heroes
  serialize :right_heroes
  serialize :winner
  serialize :first_blood
  serialize :left_ult_sequence
  serialize :right_ult_sequence
  serialize :total_kill_sequence
  serialize :total_death_sequence
  validates :roundtype, presence: true
  validates :duration, presence: true
  validates :left_players, presence: true
  validates :left_heroes, presence: true
  validates :right_players, presence: true
  validates :right_heroes, presence: true
  validates :winner, presence: true
  validates :first_blood, presence: true
  validates :left_kill_num, presence: true
  validates :right_kill_num, presence: true
  validates :left_ults_used, presence: true
  validates :right_ults_used, presence: true
  validates :left_ult_sequence, presence: true
  validates :right_ult_sequence, presence: true
  validates :total_kill_sequence, presence: true
  validates :total_death_sequence, presence: true

  def self.import(file, match)
    CSV.foreach(file.path, :headers => [:row_id, :date, :opponent, :map, :roundname, :length, :lp, :lh, :rp, :rh, :fb, :winner, :lkn, :rkn, :luu, :ruu, :tks, :rks, :lks, :tds, :lds, :rds, :lus, :rus]).with_index do |row, index|
      next if index == 0
      lh = row[:lh][1...-1].gsub("'","").gsub(" ", "").split(",").map(&:downcase)
      rh = row[:rh][1...-1].gsub("'","").gsub(" ", "").split(",").map(&:downcase)

      Fight.create(match_id: match.id, roundtype: row[:roundname], duration: row[:length], left_players: row[:lp], right_players: row[:rp], left_heroes: lh,
        right_heroes: rh, first_blood: row[:fb], winner: row[:winner], left_kill_num: row[:lkn], right_kill_num: row[:rkn], left_ults_used: row[:luu],
        right_ults_used: row[:ruu], left_ult_sequence: row[:lus], right_ult_sequence: row[:rus], total_kill_sequence: row[:tks], total_death_sequence: row[:tds])
    end
  end
end
