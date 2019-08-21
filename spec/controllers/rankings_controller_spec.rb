require 'spec_helper'
include ApplicationHelper

RSpec.describe Officials::RankingsController, :type => :controller do
  before do
    @event = create(:event, primary_ranking: true)
    @team = create(:team, rating: 1600)
    @team2 = create(:team, rating: 1800)
    @team3 = create(:team, rating: 1300)

    @event.teams << [@team, @team2, @team3]
  end

  describe 'get INDEX' do
    it 'should display teams in ranked order' do
      get :index
      expect(assigns(:custom)).to eq([@team2, @team, @team3])
    end

    it 'should display according to sort column and direction' do
      get :index, params: {d: "asc", sort: "rating"}
      expect(assigns(:custom)).to eq([@team3, @team, @team2])
    end
  end

end
