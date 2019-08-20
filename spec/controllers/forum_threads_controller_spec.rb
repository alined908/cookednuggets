require 'spec_helper'

RSpec.describe Forums::ForumThreadsController, :type => :controller do
  before do
    @user = create(:user)
    @forum_thread = create(:forum_thread)
    @forum_thread2 = create(:forum_thread)
    @new = create(:new)
    @official = create(:official, end: "2019-08-10 16:07:34")
    sign_in @user
  end

  describe 'GET index' do
    it "shows all forum threads" do
      get :index
      expect(assigns(:discs)).to match_array([@forum_thread, @forum_thread2, @new, @official])
    end

    it 'shows only discussions' do
      get :index, params: {:f => "threads"}
      expect(assigns(:discs)).to match_array([@forum_thread, @forum_thread2])
    end

    it 'shows only matches' do
      get :index, params: {:f => "matches"}
      expect(assigns(:discs)).to match_array([@official])
    end

    it 'shows only news articles' do
      get :index, params: {:f => "news"}
      expect(assigns(:discs)).to match_array([@new])
    end
  end

  describe 'GET show' do
    it 'renders the #show view' do
      get :show, params: {id: @forum_thread}
      expect(response).to render_template :show
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new thread' do
        expect{post :create, params: {forum_thread: FactoryBot.attributes_for(:forum_thread)}}.to change(ForumThread, :count).by(1)
      end

      it 'redirects to thread page' do
        post :create, params: {forum_thread: FactoryBot.attributes_for(:forum_thread)}
        expect(response).to redirect_to(thread_path(ForumThread.last))
        expect(flash[:success]).to eq("Thread successfully created")
      end
    end
    context 'with invalid attributes' do
      it 'does not create a new thread' do
        expect{post :create, params: {forum_thread: {user_id: 1, subject: "", description: "231231"}}}.to_not change(ForumThread, :count)
      end
      it 'redirects to threads#index' do
        post :create, params: {forum_thread: {user_id: 1, subject: "213231", description: ""}}
        expect(response).to redirect_to(threads_path)
        expect(flash[:danger]).to_not be nil
      end
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
      it 'located requested forum thread' do
        put :update, params:{id: @forum_thread, forum_thread: FactoryBot.attributes_for(:forum_thread)}
        assigns(:forum_thread).should eq(@forum_thread)
      end

      it 'changes threads attributes' do
        put :update, params: {id: @forum_thread, forum_thread: FactoryBot.attributes_for(:forum_thread, subject: "lul", description: "lawl")}
        @forum_thread.reload
        @forum_thread.subject.should eq("lul")
        @forum_thread.description.should eq("lawl")
      end

      it 'redirects to updated thread' do
        put :update, params:{id: @forum_thread, forum_thread: FactoryBot.attributes_for(:forum_thread, subject: "lul", description: "lawl")}
        expect(response).to redirect_to(thread_path(@forum_thread))
      end
    end

    context 'with invalid attributes' do
      it 'does not change threads attributes' do
        put :update, params: {id: @forum_thread, forum_thread: FactoryBot.attributes_for(:forum_thread, subject: "", description: "lawl")}
        @forum_thread.reload
        @forum_thread.subject.should eq("OWL Predictions")
        @forum_thread.description.should eq("What are your predictions?")
      end

      it 'redirects to thread' do
        put :update, params: {id: @forum_thread, forum_thread: FactoryBot.attributes_for(:forum_thread, subject: "", description: "lawl")}
        expect(response).to redirect_to(thread_path(@forum_thread))
        expect(flash[:danger]).to eq("Unable to update Forum Thread. There is an error with a field.")
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the thread' do
      expect{delete :destroy, params:{id: @forum_thread}}.to change(ForumThread, :count).by(-1)
    end
    it 'redirects to all threads' do
      delete :destroy, params:{id: @forum_thread}
      expect(response).to redirect_to(threads_path)
    end
  end
end
