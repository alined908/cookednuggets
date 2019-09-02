require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe '#update_count' do
    before do
      @thread = create(:forum_thread)
      @post = create(:forum_post, commentable_id: "1", commentable_type: "ForumThread")
      @vote = create(:vote)
      @post.reload
    end
    it 'updates score of forum post on creation' do
      expect(@post.score).to eq(1)
    end
    it 'updates score of forum post on deletion' do
      @vote.destroy
      @post.reload
      expect(@post.score).to eq(0)
    end
  end
end
