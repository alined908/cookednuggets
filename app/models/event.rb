class Event < ApplicationRecord
  has_one_attached :logo
  before_create :set_default_image
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

  def set_default_image
    self.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'misc', 'default-player.png')), filename: 'default-player.png', content_type: 'image/png')
  end
end
