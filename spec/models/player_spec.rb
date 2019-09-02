require 'rails_helper'

RSpec.describe Player, type: :model do
  before do
    @player = create(:player, headshot: "https://bnetcmsus-a.akamaihd.net/cms/gallery/FDHS3GHI2JY31549580254953.png")
  end

  it 'is valid with valid attributes' do
    expect(@player).to be_valid
  end

  it 'is not valid without an eng_name' do
    player = build(:player, eng_name: "")
    expect(player).to_not be_valid
  end

  it 'is not valid without a handle' do
    player = build(:player, handle: "")
    expect(player).to_not be_valid
  end

  it 'is not valid without a country' do
    player = build(:player, country: "")
    expect(player).to_not be_valid
  end

  it 'is not valid without a roles' do
    player = build(:player, roles: "")
    expect(player).to_not be_valid
  end

  describe '#get_image' do
    it 'creates an activestorage blob for the image' do
      expect(@player.avatar).to_not be nil
    end
  end

  describe '#lazy_starter' do
    context 'if the team does not have two of that role' do
      it 'assigns player to be a starter' do
        team = create(:team)
        player = create(:player, team: team)
        expect(player.starter).to eq(true)
      end
    end
    context 'if the team does have two of that role' do
      it 'makes player remain not a starter' do
        team = create(:team)
        players = create_list(:player, 3, roles: "tank")
        team.players << players
        player = create(:player, team: team, roles: "tank")
        expect(players[0].starter).to eq(true)
        expect(players[1].starter).to eq(true)
        expect(players[2].starter).to eq(false)
        expect(player.starter).to eq(false)
      end
    end
  end
end
