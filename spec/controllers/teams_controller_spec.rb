require 'spec_helper'

RSpec.describe Officials::TeamsController, :type => :controller do
  before do
    @event = create(:event)
    @teams = create_list(:team, 3)
    @user = create(:user)
    @official1 = create(:official, end: "2019-08-10 16:07:34", team1: @teams[0])
    @official2 = create(:official, end: "2019-08-10 18:07:34", team1: @teams[0])
    @official3 = create(:official, end: "2019-08-10 20:07:34", team1: @teams[0])
    sign_in @user
  end

  describe 'GET index' do
    it 'retrieves all teams' do
      get 'index'
      expect(assigns(:teams)).to match_array(@teams)
    end

    it 'renders index view' do
      get 'index'
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    it 'renders show view' do
      get 'show', params: {id: @teams[0]}
      expect(response).to render_template(:show)
    end

    it 'retrives officials of team in sorted order' do
      get 'show', params: {id: @teams[0]}
      expect(assigns(:officials)).to match_array([@official1, @official2, @official3])
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a team' do
        expect{post :create, params: {team: FactoryBot.attributes_for(:team)}}.to change(Team, :count).by(1)
        expect(Team.last.socials).to_not be nil
      end
      it 'successfully redirects to the team' do
        post :create, params: {team: FactoryBot.attributes_for(:team)}
        expect(response).to redirect_to(team_path(Team.last))
        expect(flash[:success]).to eq("Team successfully created.")
      end
    end
    context 'with invalid attributes' do
      it 'does not create a team' do
        expect{post :create, params: {team: FactoryBot.attributes_for(:team, name: "")}}.to_not change(Team, :count)
      end
      it 'successfully redirects back to teams index' do
        post :create, params: {team: FactoryBot.attributes_for(:team, name: "")}
        expect(response).to render_template("index")
        expect(flash[:danger]).to_not be nil
      end
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
      it 'updates team and redirects successfully to updaetd team' do
        put :update, params: {id: @teams[0], team: FactoryBot.attributes_for(:team, name: "dal", socials: {"TWITTER" => "twitter.com/dal", "DISCORD" => "discord.gg/sfs"})}
        @teams[0].reload
        expect(@teams[0].name).to eq("dal")
        expect(@teams[0].socials['TWITTER']).to eq('twitter.com/dal')
        expect(response).to redirect_to(team_path(@teams[0]))
        expect(flash[:success]).to eq("Successfully updated Team")
      end
    end
    context 'with invalid attributes' do
      it 'does not update team and redirects successfully to unupdated team' do
        put :update, params: {id: @teams[0], team: FactoryBot.attributes_for(:team, name: "", rating: 1800, socials: {"TWITTER" => "twitter.com/dal", "DISCORD" => "discord.gg/sfs"})}
        @teams[0].reload
        expect(@teams[0].rating).to eq(1500)
        expect(response).to redirect_to(team_path(@teams[0]))
        expect(flash[:danger]).to eq("Unable to update Team. There is an error with a field.")
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the team' do
      expect{delete :destroy, params:{id: @teams[0]}}.to change(Team, :count).by(-1)
    end

    it 'redirects to teams index' do
      delete :destroy, params:{id: @teams[0]}
      expect(response).to redirect_to(teams_path)
      expect(flash[:success]).to eq("Team '#{@teams[0].name}' successfully deleted.")
    end
  end
end
