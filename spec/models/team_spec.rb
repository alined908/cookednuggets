require 'rails_helper'

RSpec.describe Team, type: :model do

  before do
    @team = create(:team)
  end

  it 'is valid with valid attributes' do
    expect(@team).to be_valid
  end

  it 'is not valid without a name' do
    team = build(:team, name: "")
    expect(team).to_not be_valid
  end

  it 'is not valid without a country' do
    team = build(:team, country: "")
    expect(team).to_not be_valid
  end

  describe '.update_teams' do
    it 'updates teams attributes correctly' do
      @team = create(:team, streak: 5, rating: 2000, games_played: 10)
      @team2 = create(:team, streak: -2, rating: 1500, games_played: 11)

      Team.update_teams(@team2.id, @team.id, Date.current)
      @team.reload
      @team2.reload
      expect(@team.streak).to eq(-1)
      expect(@team2.streak).to eq(1)
      expect(@team.rating).to eq(1971)
      expect(@team2.rating).to eq(1528)
      expect(@team.games_played).to eq(11)
      expect(@team2.games_played).to eq(12)
      expect(@team.last_played).to eq(Date.current)

      Team.update_teams(@team2.id, @team.id, Date.current)
      @team.reload
      @team2.reload
      expect(@team.streak).to eq(-2)
      expect(@team2.streak).to eq(2)
    end
  end

  describe '#get_image' do
    it 'creates an activestorage blob for the image' do
      expect(@team.pic).to_not be nil
    end
  end
end
