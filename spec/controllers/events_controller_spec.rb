require 'spec_helper'

RSpec.describe Officials::EventsController, :type => :controller do
  before do
    @user = create(:user)
    @active = create(:event, start_date: 1.day.ago, end_date: 1.day.from_now)
    @completed = create(:event, start_date: 2.days.ago, end_date: 1.day.ago)
    @team = create(:team)
    @team2 = create(:team)
    @section = create(:section, event_id: @active.id)
    @official = create(:official, end: "2019-08-10 16:07:34", team1: @team, team2: @team2, section_id: @section.id, event_id: @active.id)
    @active.teams << @team
    @active.sections << @section
    @section.officials << @official
    sign_in @user
  end

  describe 'GET index' do
    it 'shows active events' do
      get :index
      expect(assigns(:events)).to match_array([@active])
    end

    it 'shows completed events' do
      get :index, params: {:s => "completed"}
      expect(assigns(:events)).to match_array([@completed])
    end
  end

  describe 'GET show' do
    it 'renders the show view' do
      get :show, params: {id: @active}
      expect(response).to render_template(:show)
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new event' do
        expect{post :create, params: {teams: [@team.id, @team2.id],event: FactoryBot.attributes_for(:event)}}.to change(Event, :count).by(1)
      end
      it 'redirects to event' do
        post :create, params: {event: FactoryBot.attributes_for(:event)}
        expect(response).to redirect_to(event_path(Event.last))
        expect(flash[:success]).to eq("Event successfully created.")
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new event' do
        expect{post :create, params: {event: FactoryBot.attributes_for(:event, name: "")}}.to_not change(Event, :count)
      end
      it 'redirects to events index' do
        post :create, params: {event: FactoryBot.attributes_for(:event, name: "")}
        expect(response).to redirect_to(events_path)
        expect(flash[:danger]).to_not be nil
      end
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
      it 'changes event attributes' do
        put :update, params: {id: @active, teams: [@team2],event: FactoryBot.attributes_for(:event, name: "Overwatch Contenders")}
        @active.reload
        expect(@active.name).to eq("Overwatch Contenders")
        expect(@active.teams).to match_array([@team, @team2])
      end
      it 'redirects to updated event' do
        put :update, params: {id: @active, event: FactoryBot.attributes_for(:event, name: "Overwatch Contenders")}
        expect(flash[:success]).to eq("Event successfully updated.")
        expect(response).to redirect_to(event_path(@active))
      end
    end

    context 'with invalid attributes' do
      it 'does not change event attributes' do
        put :update, params: {id: @active, event: FactoryBot.attributes_for(:event, name: "")}
        @active.reload
        expect(@active.name).to eq("Overwatch League")
      end
      it 'redirects to not updated event' do
        put :update, params: {id: @active, event: FactoryBot.attributes_for(:event, name: "")}
        expect(flash[:danger]).to_not be nil
        expect(response).to redirect_to(event_path(@active))
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the event' do
      expect{delete :destroy, params:{id: @active}}.to change(Event, :count).by(-1)
    end
    it 'redirects to events index' do
      delete :destroy, params:{id: @active}
      expect(response).to redirect_to(events_path)
      expect(flash[:success]).to eq("Event '#{@active.name}' successfully deleted.")
    end
  end
end
