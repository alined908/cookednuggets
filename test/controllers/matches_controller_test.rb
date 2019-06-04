require 'test_helper'

class MatchesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:daniel)
    @match = matches(:one)
    @match2 = matches(:two)
    sign_in @user
  end

  test "should get index" do
    get user_matches_path(@user)
    assert_response :success
  end

  test "should get new" do
    get new_user_match_path(@user)
    assert_response :success
  end

  test "should create match" do
    assert_difference('Match.count') do
      post user_matches_path(@user), params: { match: { date: @match.date, map: @match.map, opponent: @match.opponent } }
    end

    assert_redirected_to user_match_path(@user, Match.last)
  end

  test "should show match" do
    get user_match_path(@user, @match)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_match_path(@user, @match)
    assert_response :success
  end

  test "should update" do
    get edit_user_match_path(@user, @match)
    patch user_match_path(@user, @match), params: {match: {date: @match2.date, map: @match2.map, opponent: @match2.opponent}}
    assert_response :success
  end

  test "should destroy match" do
    assert_difference('Match.count', -1) do
      delete user_match_path(@user, @match)
    end

    assert_redirected_to user_matches_path(@user)
  end
end
