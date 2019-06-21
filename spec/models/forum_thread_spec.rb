require "rails_helper"

RSpec.describe ForumThread, :type => :model do
  before do
    @forum_thread1 = create(:forum_thread)
  end

  it "is valid with valid attributes" do
    expect(@forum_thread1).to be_valid
  end

  it "has a subject" do
    forum_thread2 = build(:forum_thread, subject: "")
    expect(forum_thread2).to_not be_valid
  end

  it "has a description" do
    forum_thread2 = build(:forum_thread, description: "")
    expect(forum_thread2).to_not be_valid
  end
end
