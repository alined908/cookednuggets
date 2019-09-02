require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @active = create(:event, start_date: 1.day.ago, end_date: 1.day.from_now)
    @completed = create(:event, start_date: 2.days.ago, end_date: 1.day.ago)
  end

  it 'is valid with valid attributes' do
    expect(@active).to be_valid
    expect(@completed).to be_valid
  end

  it 'is not valid without name' do
    event = build(:event, name: "")
    expect(event).to_not be_valid
  end

  it 'is not valid without location' do
    event = build(:event, location: "")
    expect(event).to_not be_valid
  end

  it 'is not valid without prize' do
    event = build(:event, prize: nil)
    expect(event).to_not be_valid
  end

  it 'is not valid without start_date' do
    event = build(:event, start_date: nil)
    expect(event).to_not be_valid
  end

  describe '#add_teams' do
    it 'adds an array of team ids correctly' do
      @teams = create_list(:team, 3)
      @active.add_teams(@teams.pluck(:id))
      expect(@active.teams.count).to eq(3)
    end
  end

  describe '#check_teams' do
    before do
      @teams = create_list(:team, 3)
      @team = create(:team)
      @active.teams << @teams
    end

    it 'adds and deletes correctly a list of team ids' do
      @active.check_teams([1,2,4])
      expect(@active.teams.pluck(:id)).to contain_exactly(1,2,4)
      expect(@active.teams).to_not contain_exactly(@teams[3])
    end
  end
end
