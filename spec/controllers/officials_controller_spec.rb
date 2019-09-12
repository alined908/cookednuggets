require 'spec_helper'

RSpec.describe Officials::OfficialsController, :type => :controller do
  before do
    @user = create(:user)
    @event = create(:event)
    @team = create(:team)
    @team2 = create(:team)
    @section1 = create(:section, event: @event)
    @section2 = create(:section, event: @event)
    @event.teams << [@team, @team2]
    @official = create(:official, team1: @team, team2: @team2, event: @event, section: @section1, start: 2.days.ago, end: 1.day.ago)
    @official1 = create(:official, team1: @team, team2: @team2, event: @event, section: @section1, start: 2.days.from_now, end: 3.days.from_now)
    @official2 = create(:official, team1: @team, team2: @team2, event: @event, section: @section1, start: 1.day.from_now, end: 2.days.from_now)
    @official3 = create(:official, team1: @team, team2: @team2, event: @event, section: @section1, start: 1.day.ago, end: Date.current)
    sign_in @user
  end

  describe 'GET index' do
    it 'renders the index view' do
      get 'index'
      expect(response).to render_template(:index)
    end
    it 'shows only upcoming on default' do
      get 'index'
      expect(assigns(:officials)).to match_array([@official2, @official1])
    end
    it 'shows only completed if param given' do
      get 'index', params:{f: "comp"}
      expect(assigns(:officials)).to match_array([@official3, @official])
    end
  end

  describe 'GET show' do
    it 'renders the show view' do
      get 'show', params: {id: @official}
      expect(response).to render_template(:show)
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a match' do
        expect{post :create, params: {official: @official.attributes}}.to change(@section1.officials, :count).by(1)
      end
      it 'successfully redirects back to the match' do
        post :create, params: {official: @official.attributes}
        expect(response).to redirect_to(match_path(Official.last))
        expect(flash[:success]).to eq("Match successfully created.")
      end
    end
    context 'with invalid attributes' do
      it 'does not create a match' do
        expect{post :create, params: {official: build(:official, event: @event, section: @section1, start: 2.days.ago, end: 1.day.ago).attributes}}.to_not change(@section1.officials, :count)
      end

      it 'successfully redirects back to the event section path' do
        post :create, params: {official: build(:official, event: @event, section: @section1, start: 2.days.ago, end: 1.day.ago).attributes}
        expect(response).to redirect_to(event_section_path(@event, @section1))
        expect(flash[:danger]).to_not be nil
      end
    end
  end

  describe 'PATCH update' do
    context 'with valid attributes' do
      it 'updates a match and redirects successfully' do
        put :update, params: {id: @official, official: FactoryBot.attributes_for(:official, event: @event, section: @section1, match_type: "playoffs")}
        @official.reload
        expect(@official.match_type).to eq("playoffs")
        expect(response).to redirect_to(match_path(@official))
        expect(flash[:success]).to eq("Match successfully updated.")
      end
    end
    context 'with invalid attributes' do
      it 'does not update a match and redirects successfully' do
        put :update, params: {id: @official, official: FactoryBot.attributes_for(:official, event: @event, section: @section1, start: nil)}
        @official.reload
        expect(@official.start).to_not be nil
        expect(response).to redirect_to(match_path(@official))
        expect(flash[:danger]).to eq("Unable to edit match. Field incorrectly inputted.")
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the match' do
      expect{delete :destroy, params:{id: @official}}.to change(Official, :count).by(-1)
    end
    it 'redirects successfully' do
      delete :destroy, params:{id: @official}
      expect(response).to redirect_to(event_section_path(@event, @section1))
      expect(flash[:success]).to eq("Successfully destroyed match")
    end
  end
end
