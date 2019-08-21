require 'spec_helper'

RSpec.describe Officials::TeamsController, :type => :controller do
  before do
    @event = create(:event)
    @teams = create_list(:team, 3)
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
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a team' do

      end
      it 'successfully redirects to the team' do

      end
    end
    context 'with invalid attributes' do
      it 'does not create a team' do

      end
      it 'successfully redirects back to teams index' do

      end
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
      it 'updates team' do

      end
      it 'redirects successfully to updated team' do

      end
    end
    context 'with invalid attributes' do
      it 'does not update team' do

      end
      it 'redirects successfully to not updated team' do

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
