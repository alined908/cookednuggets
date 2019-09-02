require 'rails_helper'

RSpec.describe Section, type: :model do
  before do
    @event = create(:event)
    @section = create(:section, event: @event)
  end

  it 'is valid with valid attributes' do
    expect(@section).to be_valid
  end

  it 'is not valid without a name' do
    section = build(:section, event: @event, name: "")
  end

  it 'is not valid without a start' do
    section = build(:section, event: @event, start: nil)
  end

  describe '.standings' do
    before do
      @teams = create_list(:team, 2)
      @event.teams << @teams
      @official1 = create(:official, team1: @teams[0], team2: @teams[1], winner: @teams[0], score: [2,1], event: @event, section: @section, identifier: 2, end: "2019-08-10 16:07:34")
      @map1 = create(:map, official_id: @official1.id, winner: @teams[0])
      @map2 = create(:map, official_id: @official1.id, winner: @teams[0])
      @map3 = create(:map, official_id: @official1.id, winner: @teams[1])
      @map4 = create(:map, official_id: @official1.id, winner: nil)
      @official2 = create(:official, team1: @teams[0], team2: @teams[1], winner: @teams[1], score: [0,3], event: @event, section: @section, identifier: 2, end: "2019-08-10 16:07:34")
      @map1 = create(:map, official_id: @official2.id, winner: @teams[1])
      @map2 = create(:map, official_id: @official2.id, winner: @teams[1])
      @map3 = create(:map, official_id: @official2.id, winner: @teams[1])
      @map4 = create(:map, official_id: @official2.id, winner: nil)
    end

    it 'creates a table of sorted standings' do
      returned = Section.standings(@event.teams, @section.officials)
      sorted_teams, standings = returned[0], returned[1]
      expect(standings).to eq({@teams[0].name => {'match': [1,1], 'map': [2,4,2]}, @teams[1].name => {'match': [1,1], 'map': [4,2,2]}})
      expect(sorted_teams).to eq([@teams[1], @teams[0]])
    end

  end

end
