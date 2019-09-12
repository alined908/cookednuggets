require "rails_helper"

RSpec.describe ForumPost, :type => :model do
  before do
    @forum_thread = create(:forum_thread)
    @new = create(:new)
    @official = create(:official, end: "2019-08-10 16:07:34")
    @forum_post1 = create(:forum_post, commentable_id: @forum_thread.id, commentable_type: "ForumThread")
  end

  it "is valid with valid attributes" do
    expect(@forum_post1).to be_valid
  end

  it "is not valid without a body" do
    forum_post2 = build(:forum_post, body: "")
    expect(forum_post2).to_not be_valid
  end

  describe ".find_parent" do
    it 'obtains parent of post correctly' do
      forum_post2 = create(:forum_post, commentable_id: @new.id, commentable_type: "New")
      forum_post3 = create(:forum_post, commentable_id: @official.id, commentable_type: "Official")
      expect(ForumPost.find_parent(forum_post2)).to eq(@new)
      expect(ForumPost.find_parent(forum_post3)).to eq(@official)
    end
  end

  describe "#update_count" do
    it 'updates post_count of parent correctly after creation' do
      @forum_post2 = create(:forum_post, commentable_id: @forum_thread.id, commentable_type: "ForumThread")
      @forum_thread.reload
      expect(@forum_thread.comments_count).to eq(2)
    end

    it 'updates post count of parent correctly after deletion' do
      @forum_post1.destroy
      @forum_thread.reload
      expect(@forum_thread.comments_count).to eq(0)
    end
  end
end
