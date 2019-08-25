require 'spec_helper'

RSpec.describe Officials::PlayersController, :type => :controller do
  before do
    @user = create(:user)
    sign_in @user
    @players = create_list(:player, 5)
    @team = create(:team)
    @official1 = create(:official, start: "2019-08-10 14:07:34", end: "2019-08-10 16:07:34")
    @official2 = create(:official, start: "2019-08-12 14:07:34", end: "2019-08-12 16:07:34")
    @map1 = create(:map, official: @official1, state: "completed")
    @map2 = create(:map, official: @official2, state: "completed" )
    @performance1 = create(:performance, player: @players[0], map: @map1)
    @performance2 = create(:performance, player: @players[0], map: @map2)
  end

  describe 'GET index' do
    it 'renders index view and retrieves all players' do
      get 'index'
      expect(response).to render_template(:index)
      expect(assigns(:players)).to match_array(@players)
    end
  end

  describe 'GET show' do
    it 'retrieves players recent matches and renders show view' do
      get 'show', params: {id: @players[0]}
      expect(response).to render_template(:show)
      expect(assigns(:recent_matches)).to match_array([@official2, @official1])
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a player and successfully redirects to player' do
        expect{post :create, params: {player: FactoryBot.attributes_for(:player)}}.to change(Player, :count).by(1)
      end
      it 'successfully redirects to player' do
        post :create, params: {player: FactoryBot.attributes_for(:player)}
        expect(response).to redirect_to(player_path(Player.last))
        expect(flash[:success]).to eq("Player successfully created")
      end
    end
    context 'with invalid attributes' do
      it 'does not create a player and successfully redirects to players index' do
        expect{post :create, params: {player: FactoryBot.attributes_for(:player, handle: "")}}.to_not change(Player, :count)
        expect(response).to redirect_to(players_path)
        expect(flash[:danger]).to_not be nil
      end
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
      it 'updates player and successfully redirects back to player' do
        put :update, params: {id: @players[0], player: FactoryBot.attributes_for(:player, handle: "a")}
        @players[0].reload
        expect(@players[0].handle).to eq("a")
        expect(response).to redirect_to(player_path(@players[0]))
        expect(flash[:success]).to eq("Successfully updated Player")
      end
    end
    context 'with invalid attributes' do
      it 'does not update player and successfully redirects back to player with error message' do
        put :update, params: {id: @players[0], player: FactoryBot.attributes_for(:player, handle: "")}
        @players[0].reload
        expect(@players[0].handle).to eq("daw")
        expect(response).to redirect_to(player_path(@players[0]))
        expect(flash[:danger]).to eq("Unable to update Player. There is an error with a field.")
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the player and redirects to players index' do
      expect{delete :destroy, params:{id: @players[0]}}.to change(Player, :count).by(-1)
      expect(response).to redirect_to(players_path)
      expect(flash[:success]).to eq("Player successfully deleted.")
    end
  end
end
