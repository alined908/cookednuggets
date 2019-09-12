require 'spec_helper'

RSpec.describe News::NewsController, :type => :controller do
  before do
    @user = create(:user)
    @new = create(:new)
    sign_in @user
  end

  describe 'GET show' do
    it 'renders the #show view' do
      get :show, params: {id: @new}
      expect(response).to render_template :show
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a News article' do
        expect{post :create, params: {new: FactoryBot.attributes_for(:new)}}.to change(New, :count).by(1)
      end
      it 'redirects correctly w/ message' do
        post :create, params: {new: FactoryBot.attributes_for(:new)}
        expect(response).to redirect_to(news_path(New.last))
        expect(flash[:success]).to eq("Article successfully created")
      end
    end
    context 'with invalid attributes' do
      it 'does not create a News article' do
        expect{post :create, params: {new: FactoryBot.attributes_for(:new, subject: "")}}.to_not change(New, :count)
      end
      it 'redirects correctly w/ message' do
        post :create, params: {new: FactoryBot.attributes_for(:new, subject: "")}
        expect(response).to redirect_to(threads_path(:f => "news"))
        expect(flash[:danger]).to_not be nil
      end
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
      it 'updates a News article' do
        put :update, params: {id: @new, new: FactoryBot.attributes_for(:new, article: "Florida Mayhem suckss")}
        @new.reload
        expect(@new.article).to eq("Florida Mayhem suckss")
      end
      it 'redirects correctly w/ message' do
        put :update, params: {id: @new, new: FactoryBot.attributes_for(:new, article: "Florida Mayhem suckss")}
        expect(response).to redirect_to(news_path(@new))
        expect(flash[:success]).to eq("Successfully updated news article")
      end
    end
    context 'with invalid attributes' do
      it 'does not update a News article' do
        put :update, params: {id: @new, new: FactoryBot.attributes_for(:new, subject: "")}
        @new.reload
        expect(@new.subject).to eq("Subject")
      end
      it 'redirects correctly w/ message' do
        put :update, params: {id: @new, new: FactoryBot.attributes_for(:new, subject: "")}
        expect(response).to redirect_to(news_path(@new))
        expect(flash[:danger]).to_not be nil
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the news article' do
      expect{delete :destroy, params:{id: @new}}.to change(New, :count).by(-1)
    end

    it 'redirects to news index' do
      delete :destroy, params:{id: @new}
      expect(response).to redirect_to(threads_path(:f => "news"))
    end
  end
end
