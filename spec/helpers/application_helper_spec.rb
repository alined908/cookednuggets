require 'spec_helper'

describe ApplicationHelper do
  include Devise::Test::ControllerHelpers
  before do
    @official = create(:official, end: Date.tomorrow)
    @new = create(:new)
    @thread = create(:forum_thread)
    @post = create(:forum_post)
    @vote = create(:vote)
    @team = create(:team, rating: 1800)
    @team2 = create(:team, rating: 1600)
    @vote2 = create(:vote, direction: -1)
  end

  describe "#current_class?" do
    it "checks if path is active" do
      expect(helper.current_class?(matches_path)).to eq("")
    end
  end

  describe "#disc_path?" do
    it "returns information for match path if requested is a Match" do
      expect(helper.disc_path?(@official)).to eq([match_path(@official), "type-match", "Matches", threads_path(:f => "matches")])
    end
    it "returns information for news path if requested is a News article" do
      expect(helper.disc_path?(@new)).to eq([news_path(@new), "type-news", "News",threads_path(:f => "news") ])
    end
    it "returns information for thread path if requested is a ForumThread" do
      expect(helper.disc_path?(@thread)).to eq([thread_path(@thread), "type-forum", "Discussions",threads_path(:f => "threads") ])
    end
  end

  describe "#get_author" do
    it "returns author of ForumThread" do
      expect(helper.get_author(@thread)).to eq (@thread.user.username.capitalize)
    end
    it "returns author of New" do
      expect(helper.get_author(@new)).to eq (@new.user.username.capitalize)
    end
    it "doesnt return author of Official" do
      expect(helper.get_author(@official)).to eq ("")
    end
  end

  describe "#map_diff" do
    it "returns blank if diff is 0" do
      expect(helper.map_diff(0)).to eq("")
    end
    it "returns blank if diff is < 0" do
      expect(helper.map_diff(-1)).to eq("negative")
    end
    it "returns blank if diff is > 0" do
      expect(helper.map_diff(1)).to eq("positive")
    end
  end

  describe "active_vote?" do
    it "highlights nothing if not signed in" do
      expect(helper.active_vote?(@post)).to eq(["", ""])
    end
    it "highlights previously voted on direction if user is signed in and voted on post" do
      sign_in @vote.user
      expect(helper.active_vote?(@post)).to eq(["positive", ""])
      sign_out @vote.user
      sign_in @vote2.user
      expect(helper.active_vote?(@post)).to eq(["", "negative"])
    end
  end

  describe "#find_post_route?" do
    it "returns thread path if post is child of ForumThread" do
      expect(helper.find_post_route?(@post)).to eq(thread_post_path(thread_id: @post.commentable.id, id: @post.id))
    end
    it "returns post path if post is child of ForumPost" do
      @post = create(:forum_post, commentable_id: @post.id, commentable_type: "ForumPost")
      expect(helper.find_post_route?(@post)).to eq(post_post_path(post_id: @post.commentable.id, id: @post.id))
    end
    it "returns match path if post is child of Official" do
      @post = create(:forum_post, commentable_id: @official.id, commentable_type: "Official")
      expect(helper.find_post_route?(@post)).to eq(match_post_path(match_id: @post.commentable.id, id: @post.id))
    end
    it "returns news path if post is child of New" do
      @post = create(:forum_post, commentable_id: @new.id, commentable_type: "New")
      expect(helper.find_post_route?(@post)).to eq(news_post_path(news_id: @post.commentable.id, id: @post.id))
    end
  end

  describe "#probability?" do
    it "returns probability of team1 vs team2" do
      expect(helper.probability?(@team2.rating, @team.rating).round(2)).to eq(0.76)
    end
  end

  describe "#elo_rating?" do
    it "returns correct updated rating of winner and loser" do
      expect(helper.elo_rating?(1200, 1000, 32).map{|rating| rating.to_i}).to eq([1207, 992])
    end
  end

  describe "#streak_helper?" do
    it "returns nothing if streak is 0" do
      expect(helper.streak_helper?(0)).to eq([0, ""])
    end
    it "returns L if streak is < 0" do
      expect(helper.streak_helper?(-1)).to eq([1, "L"])
    end
    it "returns W if streak is > 0" do
      expect(helper.streak_helper?(1)).to eq([1, "W"])
    end
  end

  describe "#get_time_ago" do
    it "returns a formatted time string" do
      expect(helper.get_time_ago(1.day.ago)).to eq("1 day")
    end
  end

  describe "#get_time_string" do
    it "returns a formatted time string" do
      expect(helper.get_time_string(DateTime.new(2019, 12, 20, 11, 10, 0))).to eq("2019-12-20 11:10")
    end
  end
end
