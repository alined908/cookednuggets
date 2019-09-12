require 'spec_helper'

RSpec.describe Officials::MapsController, :type => :controller do
  before do
    @user = create(:user)
    sign_in @user
    @event = create(:event)
    @team = create(:team)
    @team2 = create(:team)
    @section1 = create(:section, event: @event)
    @section2 = create(:section, event: @event)
    @event.teams << [@team, @team2]
    @official = create(:official, team1: @team, team2: @team2, event: @event, section: @section1, start: 2.days.ago, end: 1.day.ago)
    @maps = create_list(:map, 3, official: @official)
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new map for the match' do
        expect{post :create, params: {match_id: @official, map: FactoryBot.attributes_for(:map, official_id: @official)}}.to change(@official.maps, :count).by(1)
      end
      it 'redirects successfully back to match' do
        post :create, params: {match_id: @official, map: FactoryBot.attributes_for(:map, official_id: @official)}
        expect(response).to redirect_to(match_path(@official))
        expect(flash[:success]).to eq("Successfully created a map")
      end
    end
    context 'with invalid attributes' do
      it 'does not create a new map for the match' do
        expect{post :create, params: {match_id: @official, map: FactoryBot.attributes_for(:map, state: nil, official_id: @official)}}.to_not change(@official.maps, :count)
      end
      it 'redirects successfully back to match' do
        post :create, params: {match_id: @official, map: FactoryBot.attributes_for(:map, state: nil, official_id: @official)}
        expect(response).to redirect_to(match_path(@official))
        expect(flash[:danger]).to_not be nil
      end
    end
  end

  describe 'PATCH update' do
    context 'with valid attributes' do
      it 'updates the map and redirects successfully back to match' do
        put :update, params: {match_id: @official, id: @maps[0], map: FactoryBot.attributes_for(:map, name: "Rialto", official_id: @official)}
        @maps[0].reload
        expect(@maps[0].name).to eq("Rialto")
      end
    end
    context 'with invalid attributes' do
      it 'does not update the map and redirects successfully back to match' do
        put :update, params: {match_id: @official, id: @maps[0], map: FactoryBot.attributes_for(:map, state: nil, official_id: @official)}
        @maps[0].reload
        expect(@maps[0].name).to eq("Lijiang")
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the map' do
      expect{delete :destroy, params:{match_id: @official, id: @maps[0]}}.to change(@official.maps, :count).by(-1)
    end
    it 'redirects to the match' do
      delete :destroy, params:{match_id: @official, id: @maps[0]}
      expect(response).to redirect_to(match_path(@official))
      expect(flash[:success]).to eq("Successfully deleted map")
    end
  end
end
