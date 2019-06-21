require "rails_helper"

RSpec.describe User, :type => :model do
  before do
    @user1 = create :user
  end

  it "is valid with valid attributes" do
    expect(@user1).to be_valid
  end

  it "has a unique email" do
    user2 = build(:user, username: "ok")
    expect(user2).to_not be_valid
  end

  it "has a password" do
    user2 = build(:user, password: nil)
    expect(user2).to_not be_valid
  end

end
