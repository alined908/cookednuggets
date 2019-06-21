require "rails_helper"

RSpec.describe ForumPost, :type => :model do
  before do
    @forum_thread = create(:forum_thread)
    @forum_post1 = create(:forum_post, commentable_id: @forum_thread.id, commentable_type: "ForumThread")
  end

  it "is valid with valid attributes" do
    expect(@forum_post1).to be_valid
  end

  it "has a body" do
    forum_post2 = build(:forum_post, body: "")
    expect(forum_post2).to_not be_valid
  end

end
