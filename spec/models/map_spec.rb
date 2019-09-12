require 'rails_helper'

RSpec.describe Map, type: :model do
  before do
    @team1_players = create_list(:player, 3, starter: true)
    @team2_players = create_list(:player, 3, starter: true)
    @teams = create_list(:team, 2)
    @teams[0].players << @team1_players
    @teams[1].players << @team2_players
    @event = create(:event)
    @section = create(:section, event: @event)
    @event.teams << @teams
    @official1 = create(:official, team1: @teams[0], team2: @teams[1], winner: @teams[0], score: [2,1], event: @event, section: @section, identifier: 2, end: "2019-08-10 16:07:34")
    @map = create(:map, official_id: @official1.id, winner: @teams[0])
    @performance1 = create(:performance, map: @map, team: @teams[0], player: @team1_players[0])
    @performance2 = create(:performance, map: @map, team: @teams[1], player: @team2_players[0])
  end

  it 'is valid with valid attributes' do
    expect(@map).to be_valid
  end

  it 'is not valid without a state' do
    map = build(:map, state: "")
    expect(map).to_not be_valid
  end

  describe '.get_perfs' do
    context 'if map has no performances' do
      it 'grabs players of the two teams' do
        @map.performances.destroy_all
        returned = Map.get_perfs(@official1.maps, @teams)
        expect(returned).to eq(@official1.maps.includes(performances: :player).map {|map|
          map.as_json.merge({players: [@teams[0].players.where(starter: true), @teams[1].players.where(starter:true)]})})
      end
    end

    context 'if map has performances' do
      it 'grabs the performances' do
        returned = Map.get_perfs(@official1.maps, @teams)
        expect(returned).to eq(@official1.maps.includes(performances: :player).map {|map|
          map.as_json.merge({players: [map.performances.reject{|play| play.team_id != @teams[0].id}.collect {|perf| perf.player}, map.performances.reject{|play| play.team_id != @teams[1].id}.collect {|perf| perf.player}]})
        })
      end
    end
  end

  describe '#def_players' do
    it 'updates the players/performances to the correct ones' do
      new_player = create(:player)
      new_player2 = create(:player)
      @teams[0].players << new_player
      @teams[1].players << new_player2
      @map.def_players([1, 6, 3, 4, 5, 7])
      expect(@team1_players[1].performances.count).to eq(0)
      expect(@team2_players[2].performances.count).to eq(0)
      expect(@team1_players[0].performances.count).to eq(1)
    end
  end

  describe '#team1_perfs, #team2_perfs' do
    it 'obtains performances of a team' do
      expect(@map.performances).to contain_exactly(@performance1, @performance2)
    end
  end

  describe '#create_performances' do
    it 'creates default performances after map creation' do
      official = create(:official, team1: @teams[0], team2: @teams[1], winner: @teams[0], score: [2,1], identifier: nil, event: @event, section: @section, end: "2019-08-10 16:07:34")
      map = create(:map, official_id: official.id, winner: @teams[0])
      expect(map.performances.count).to eq(@teams[0].players.count + @teams[1].players.count)
    end
  end
end
