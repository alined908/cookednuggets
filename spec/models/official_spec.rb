require 'rails_helper'

RSpec.describe Official, type: :model do
  before do
    @official = create(:official, end: "2019-08-10 16:07:34")
    @teams = create_list(:team, 2)
  end

  it 'is valid with valid attributes' do
    expect(@official).to be_valid
  end

  it 'is not valid without start' do
    official = build(:official, start: nil)
    expect(official).to_not be_valid
  end

  it 'is not valid without end' do
    official = build(:official, end: nil)
    expect(official).to_not be_valid
  end

  describe '.reverse_matches' do
    it 'if need be reverses team1 to be the given team' do
      @official = create(:official, team1: @teams[0], team2: @teams[1], end: "2019-08-10 16:07:34", score: [3, 0])
      Official.reverse_matches(@teams[1], [@official])
      expect(@official.team1).to eq(@teams[1])
    end
  end

  describe '.h2hs' do
    it 'retrieves finished matches between team1 and team2 in the past except the one given' do
      official = create(:official, team1: @teams[0], team2: @teams[1], end: "2019-08-10 16:07:34", score: [3, 0], winner: @teams[0])
      official2 = create(:official, team1: @teams[1], team2: @teams[0], end: "2019-08-20 20:07:34", score: [1, 2], winner: @teams[1])
      official3 = create(:official, team1: @teams[1], team2: @teams[0], end: "2019-08-20 20:07:34", score: [0,0])
      returned = Official.h2hs(@teams, official.id)
      expect(returned).to eq([official2])
    end
  end

  describe '.recents' do
    it 'retrieves recent matches played by the team except for the one given' do
      official = create(:official, team1: @teams[0], team2: @teams[1], end: "2019-08-10 16:07:34", score: [3, 0], winner: @teams[0])
      official2 = create(:official, team1: @teams[1], team2: @teams[0], end: "2019-08-20 20:07:34", score: [1, 2], winner: @teams[1])
      official3 = create(:official, team1: @teams[1], team2: @teams[0], end: "2019-08-20 20:07:34", score: [0,0])
      returned = Official.recents(@teams, official2.id)
      expect(returned[0].pluck(:id)).to contain_exactly(official.id)
      expect(returned[1].pluck(:id)).to contain_exactly(official.id)
    end
  end

  describe '#update_score' do
    it 'updates score of official given map win' do
      official = create(:official, team1: @teams[0], team2: @teams[1], end: "2019-08-10 16:07:34", score: [3, 0], winner: @teams[0])
      map = create(:map, official: official, winner: @teams[0])
      official.reload
      expect(official.score).to eq([4,0])
    end
  end

  describe '#give_title' do
    it 'gives title after create' do
      event = create(:event)
      section = create(:section)
      team1 = create(:team, shortname: "dal")
      team2 = create(:team, shortname: "sfs")
      official = create(:official, team1: team1 , team2: team2 , end: "2019-08-10 16:07:34")
      expect(official.subject).to eq("dal vs sfs - Overwatch League Stage 1")
    end
  end

  describe '#callback_teams' do
    it 'updates teams stats' do
      expect(@teams[0].rating).to eq(1500)
      expect(@teams[1].rating).to eq(1500)
      official = create(:official, team1: @teams[0], team2: @teams[1], end: "2019-08-10 16:07:34", score: [3,0], winner: @teams[0])
      @teams[0].reload
      @teams[1].reload
      expect(@teams[0].rating).to be > 1500
      expect(@teams[1].rating).to be < 1500
    end
  end

  describe '#default_maps' do
    it 'creates maps based on map count' do
      official = create(:official, team1: @teams[0], team2: @teams[1], end: "2019-08-10 16:07:34", map_count: 5)
      expect(official.maps.count).to eq(5)
    end
  end
end
