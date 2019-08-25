require 'spec_helper'

RSpec.describe Officials::SectionsController, :type => :controller do
  before do
    @user = create(:user)
    sign_in @user
  end

  describe 'GET index' do

  end

  describe 'GET show' do

  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a section and successfully redirects to section' do

      end
    end
    context 'with invalid attributes' do
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
    end
    context 'with invalid attributes' do
    end
  end

  describe 'DELETE destroy' do

  end
end
