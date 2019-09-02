class Event < ApplicationRecord
  has_one_attached :logo
  has_many :eventteams
  has_many :teams, through: :eventteams
  has_many :sections
  validates :name, presence: true
  validates :location, presence: true
  validates :prize, presence: true
  validates :start_date, presence: true

  def add_teams(teams)
    return if teams == nil
    teams = teams.map{|num| num.to_i}.uniq

    teams.each do |team|
      self.teams << Team.find(team)
    end
  end

  def check_teams(teams)
    return if teams == nil
    teams = teams.map{|num| num.to_i}.uniq
    self.teams.nil? ? current_teams = [] : current_teams = self.teams.pluck(:id)
    add_teams = teams - current_teams
    delete_teams = current_teams - teams

    add_teams.each do |team|
      self.teams << Team.find(team)
    end

    delete_teams.each do |team|
      self.teams.delete(Team.find(team))
    end
  end
end
