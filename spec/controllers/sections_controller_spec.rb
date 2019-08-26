require 'spec_helper'

RSpec.describe Officials::SectionsController, :type => :controller do
  before do
    @user = create(:user)
    @event = create(:event)
    @section1 = create(:section, event: @event)
    @section2 = create(:section, event: @event)
    @official = create(:official, section: @section1, end: "2019-08-10 16:07:34")
    sign_in @user
  end

  describe 'GET show' do
    it 'renders show view' do
      get 'show', params: {event_id: @event, id: @section1}
      expect(response).to render_template(:show)
    end

    it 'obtains sections of all events' do
      get 'show', params: {event_id: @event, id: @section1}
      expect(assigns(:sections)).to match_array([@section1, @section2])
      expect(assigns(:officials)).to match_array([@official])
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a section' do
        expect{post :create, params: {event_id: @event, section: FactoryBot.attributes_for(:section)}}.to change(@event.sections, :count).by(1)
      end
      it 'successfully redirects back to section' do
        post :create, params: {event_id: @event, section: FactoryBot.attributes_for(:section)}
        expect(response).to redirect_to(event_section_path(@event, Section.last))
        expect(flash[:success]).to eq("Section successfully created.")
      end
    end
    context 'with invalid attributes' do
      it 'does not creates a section' do
        expect{post :create, params: {event_id: @event, section: FactoryBot.attributes_for(:section, name: "")}}.to_not change(@event.sections, :count)
      end
      it 'successfully redirects back to event page' do
        post :create, params: {event_id: @event, section: FactoryBot.attributes_for(:section, name: "")}
        expect(response).to redirect_to(event_path(@event))
        expect(flash[:danger]).to_not be nil
      end
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
      it 'updates the section and redirects successfully' do
        put :update, params: {event_id: @event, id: @section1, section: FactoryBot.attributes_for(:section, name: "Stage 3")}
        @section1.reload
        expect(@section1.name).to eq("Stage 3")
        expect(response).to redirect_to(event_section_path(@event, @section1))
        expect(flash[:success]).to eq("Successfully updated section")
      end
    end
    context 'with invalid attributes' do
      it 'does not update the section and redirects successfully' do
        put :update, params: {event_id: @event, id: @section1, section: FactoryBot.attributes_for(:section, name: "")}
        @section1.reload
        expect(@section1.name).to eq("Stage 1")
        expect(response).to redirect_to(event_section_path(@event, @section1))
        expect(flash[:danger]).to eq("Unable to update section.")
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the section' do
      expect{delete :destroy, params:{event_id: @event, id: @section1}}.to change(@event.sections, :count).by(-1)
    end
    it 'redirects successfully' do
      delete :destroy, params:{event_id: @event, id: @section1}
      expect(response).to redirect_to(event_path(@event))
      expect(flash[:success]).to eq("Successfully destroyed section")
    end
  end
end
