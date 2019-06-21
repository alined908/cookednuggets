require 'spec_helper'

RSpec.describe Forums::ForumPostsController, :type => :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user1 = create(:user)
    @user2 = create(:user)
    @forum_thread = create(:forum_thread)
    @forum_post = create(:forum_post)
    sign_in @user1
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new post and redirects to thread w/ success' do
        expect{post :create, params: {forum_thread_id: @forum_thread.id, forum_post: FactoryBot.attributes_for(:forum_post)}}.to change(ForumPost, :count).by(1)
        expect(response).to redirect_to(forum_thread_path(@forum_thread.id))
        expect(flash[:success]).to_not be nil
      end
    end
    context  'with invalid attributes' do
      it 'does not create a new post and redirects w/fail' do
        expect{post :create, params: {forum_thread_id: @forum_thread.id, forum_post: FactoryBot.attributes_for(:forum_post, :invalid)}}.to_not change(ForumPost, :count)
        expect(response).to redirect_to(forum_thread_path(@forum_thread.id))
        expect(flash[:danger]).to_not be nil
      end
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
      it 'edits post and redirects to thread w/success' do
        put :update, params: {id: @forum_post.id, forum_thread_id: @forum_thread.id, forum_post: FactoryBot.attributes_for(:forum_post, body: "Florida Mayhem sucks")}
        @forum_post.reload
        expect(@forum_post.body).to eq("Florida Mayhem sucks")
        expect(response).to redirect_to(forum_thread_path(@forum_thread.id))
      end
    end
    context 'with invalid attributes' do
      it 'does not edit post and redirects to thread w/failure' do
        put :update, params: {id: @forum_post.id, forum_thread_id: @forum_thread.id, forum_post: FactoryBot.attributes_for(:forum_post, body: "")}
        @forum_post.reload
        expect(@forum_post.body).to_not eq("")
        expect(response).to redirect_to(forum_thread_path(@forum_thread.id))
      end
    end
  end
end
