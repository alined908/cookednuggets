require 'spec_helper'

RSpec.describe Forums::ForumThreadsController, :type => :controller do
  before do
    @user = create(:user)
    @forum_thread = create(:forum_thread)
    @forum_thread2 = create(:forum_thread, subject: "Subject")
    @forum_post = create(:forum_post)
  end

  describe 'GET index' do
    it "shows all forum threads" do
      get :index
      expect(assigns(:forum_threads)).to eq([@forum_thread, @forum_thread2])
    end
    it "shows thread info" do
      get :index
      expect((assigns(:thread_info))[0]).to include("1 minute", 1)
      expect((assigns(:thread_info))[1]).to include("1 minute", 0)
    end
    it "renders index view" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe 'GET show' do
    it 'renders show view' do
      get :show, params: {:id => @forum_thread.id}
      expect(response).to render_template("show")
    end
  end

  describe 'POST create' do
    before do
      sign_in @user
    end
    context 'with valid attributes' do
      it 'creates a new thread' do
        expect{post :create, params: {forum_thread: FactoryBot.attributes_for(:forum_thread)}}.to change(ForumThread, :count).by(1)
      end

      it 'redirects to thread page' do
        post :create, params: {forum_thread: FactoryBot.attributes_for(:forum_thread)}
        expect(response).to redirect_to(ForumThread.last)
        expect(flash[:success]).to_not be nil
      end
    end
    context 'with invalid attributes' do
      it 'does not create a new thread' do
        expect{post :create, params: {forum_thread: {user_id: 1, subject: "", description: "231231"}}}.to_not change(ForumThread, :count)
      end
      it 'redirects to threads#index' do
        post :create, params: {forum_thread: {user_id: 1, subject: "213231", description: ""}}
        expect(response).to redirect_to(forum_threads_path)
        expect(flash[:danger]).to_not be nil
      end
    end
  end

end
