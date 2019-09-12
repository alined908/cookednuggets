require 'spec_helper'

RSpec.describe Forums::ForumPostsController, :type => :controller do
  before do
    @user = create(:user)
    @forum_thread = create(:forum_thread)
    @forum_post = create(:forum_post, score: 0)
    @official = create(:official, end: "2019-08-10 16:07:34")
    @new = create(:new)
    @forum_post2 = create(:forum_post, commentable_id: @forum_post.id, commentable_type: "ForumPost")
    sign_in @user
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new post of a ForumThread' do
        expect{post :create, params: {thread_id: @forum_thread, forum_post: FactoryBot.attributes_for(:forum_post)}}.to change(ForumPost, :count).by(1)
        post :create, params: {thread_id: @forum_thread, forum_post: FactoryBot.attributes_for(:forum_post)}
        expect(response).to redirect_to(thread_path(@forum_thread))
        expect(flash[:success]).to_not be nil
      end
      it 'creates a new post of an Official and redirects to Official' do
        expect{post :create, params: {match_id: @official, forum_post: FactoryBot.attributes_for(:forum_post, commentable_id: @official.id, commentable_type: "Official")}}.to change(ForumPost, :count).by(1)
        post :create, params: {match_id: @official, forum_post: FactoryBot.attributes_for(:forum_post, commentable_id: @official.id, commentable_type: "Official")}
        expect(response).to redirect_to(match_path(@official))
        expect(flash[:success]).to_not be nil
      end
      it 'creates a new post of a New and redirects to New' do
        expect{post :create, params: {news_id: @new, forum_post: FactoryBot.attributes_for(:forum_post, commentable_id: @new.id, commentable_type: "New")}}.to change(ForumPost, :count).by(1)
        post :create, params: {news_id: @new, forum_post: FactoryBot.attributes_for(:forum_post, commentable_id: @new.id, commentable_type: "New")}
        expect(response).to redirect_to(news_path(@new))
        expect(flash[:success]).to_not be nil
      end
      it 'creates a new post of a ForumPost and redirects to ForumThread' do
        expect{post :create, params: {post_id: @forum_post, forum_post: FactoryBot.attributes_for(:forum_post, commentable_id: @forum_post.id, commentable_type: "ForumPost")}}.to change(ForumPost, :count).by(1)
        post :create, params: {post_id: @forum_post, forum_post: FactoryBot.attributes_for(:forum_post, commentable_id: @forum_post.id, commentable_type: "ForumPost")}
        expect(response).to redirect_to(thread_path(@forum_thread))
        expect(flash[:success]).to_not be nil
      end
    end
    context  'with invalid attributes' do
      it 'does not create a new post' do
        expect{post :create, params: {thread_id: @forum_thread, forum_post: FactoryBot.attributes_for(:forum_post, body: "")}}.to_not change(ForumPost, :count)
      end

      it 'redirects to correct parent' do
        post :create, params: {thread_id: @forum_thread, forum_post: FactoryBot.attributes_for(:forum_post, body: "")}
        expect(response).to redirect_to(thread_path(@forum_thread))
        expect(flash[:danger]).to_not be nil
      end
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
      it 'edits post' do
        put :update, params: {id: @forum_post, thread_id: @forum_thread, forum_post: FactoryBot.attributes_for(:forum_post, body: "Florida Mayhem sucks")}
        @forum_post.reload
        expect(@forum_post.body).to eq("Florida Mayhem sucks")
      end

      it 'redirects back to thread w/ success' do
        put :update, params: {thread_id: @forum_thread, id: @forum_post, forum_post: FactoryBot.attributes_for(:forum_post, body: "Florida Mayhem sucks")}
        expect(response).to redirect_to(thread_path(@forum_thread))
        expect(flash[:success]).to_not be nil
      end
    end
    context 'with invalid attributes' do
      it 'does not edit post' do
        put :update, params: {id: @forum_post, thread_id: @forum_thread, forum_post: FactoryBot.attributes_for(:forum_post, body: "")}
        @forum_post.reload
        expect(@forum_post.body).to_not eq("")

      end
      it 'redirects to thread w/failure' do
        put :update, params: {id: @forum_post, thread_id: @forum_thread, forum_post: FactoryBot.attributes_for(:forum_post, body: "")}
        expect(response).to redirect_to(thread_path(@forum_thread))
        expect(flash[:danger]).to_not be nil
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the post' do
      expect{delete :destroy, params:{thread_id: @forum_thread, id: @forum_post}}.to change(ForumPost, :count).by(-1)
    end
    it 'redirects to the parent' do
      delete :destroy, params:{thread_id: @forum_thread, id: @forum_post}
      expect(flash[:success]).to_not be nil
      expect(response).to redirect_to(thread_path(@forum_thread))
    end
  end

  describe 'POST vote' do
    it 'creates a vote on the post' do
      expect{post :vote, params: {id: @forum_post, direction: 1}, xhr: true}.to change(Vote, :count).by(1)
      @forum_post.reload
      expect(@forum_post.score).to eq(1)
    end

    it 'changes vote if already exists' do
      post :vote, params: {id: @forum_post, direction: 1}, xhr: true
      @forum_post.reload
      expect{post :vote, params: {id: @forum_post, direction: -1}, xhr: true}.to_not change(Vote, :count)
      @forum_post.reload
      expect(@forum_post.score).to eq(-1)
    end
  end
end
