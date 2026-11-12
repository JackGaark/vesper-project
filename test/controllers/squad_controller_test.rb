require 'test_helper'

class SquadControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @owner = User.create!(email: 'owner@example.test', password: 'password123')
    @other = User.create!(email: 'other@example.test', password: 'password123')
    @venue = Venue.create!(name: 'Venue', description: 'Description', address: 'Address', music_genre: 'Dance')
    @package = @venue.packages.create!(name: 'Package', description: 'Description', price: 100, available_per_night: 5)
    @squad = Squad.create!(user: @owner)
    @choice = @squad.squadchosenvenues.create!(venue: @venue)
    @member = @squad.squadmembers.create!(user: @owner)
  end

  test 'other users cannot change a squad package' do
    sign_in @other
    post squad_package_path(@squad, @package), as: :js
    assert_response :forbidden
    assert_nil @squad.reload.package_id
  end

  test 'other users cannot add members to a squad' do
    sign_in @other
    assert_no_difference 'Squadmember.count' do
      patch squad_path(@squad), params: { email: @other.email }, as: :js
      assert_response :forbidden
    end
  end

  test 'venue votes must belong to the squad' do
    sign_in @owner
    other_squad = Squad.create!(user: @other)
    foreign_choice = other_squad.squadchosenvenues.create!(venue: @venue)
    post member_choose_venue_path(@squad, @member), params: { squadchosenvenue_id: foreign_choice.id }, as: :json
    assert_response :unprocessable_entity
    assert_nil @member.reload.squadchosenvenue_id
  end

  test 'show before a vote redirects to voting' do
    sign_in @owner
    get squad_path(@squad)
    assert_redirected_to member_choose_venue_path(@squad, @member)
  end

  test 'a signed in user can create a squad with choices' do
    sign_in @owner
    assert_difference ['Squad.count', 'Squadmember.count', 'Squadchosenvenue.count'], 1 do
      post squad_index_path, params: { chosenVenues: [@venue.id] }, as: :json
      assert_response :success
    end
  end
  test 'owner can vote, contribute, and view the plan' do
    sign_in @owner
    get add_sidekick_path(@squad)
    assert_response :success
    get member_choose_venue_path(@squad, @member)
    assert_response :success
    post member_choose_venue_path(@squad, @member), params: { squadchosenvenue_id: @choice.id }, as: :json
    assert_response :success
    get member_choose_contribution_path(@squad, @member)
    assert_response :success
    post member_choose_contribution_path(@squad, @member), params: { contribution: 100 }, as: :json
    assert_response :success
    assert_equal 100, @member.reload.contribution
    get squad_path(@squad)
    assert_response :success
  end

  test 'invalid contribution is rejected' do
    sign_in @owner
    post member_choose_contribution_path(@squad, @member), params: { contribution: '-2' }, as: :json
    assert_response :unprocessable_entity
    assert_nil @member.reload.contribution
  end

  test 'owner can add an existing user without evaluating email as SQL' do
    sign_in @owner
    assert_no_difference 'Squadmember.count' do
      patch squad_path(@squad, format: :js), params: { email: "' OR 1=1 --" }
      assert_response :unprocessable_entity
    end
    assert_difference 'Squadmember.count', 1 do
      patch squad_path(@squad, format: :js), params: { email: @other.email }
      assert_response :success
    end
  end

  test 'only a package from the winning venue can be selected' do
    sign_in @owner
    @member.update!(squadchosenvenue: @choice)
    other_venue = Venue.create!(name: 'Other', description: 'Description', address: 'Address', music_genre: 'Dance')
    foreign_package = other_venue.packages.create!(name: 'Other package', description: 'Description', price: 100, available_per_night: 5)
    post squad_package_path(@squad, foreign_package, format: :js)
    assert_response :unprocessable_entity
    assert_nil @squad.reload.package_id
    post squad_package_path(@squad, @package, format: :js)
    assert_response :success
    assert_equal @package.id, @squad.reload.package_id
  end

  test 'nonmembers cannot view a squad' do
    sign_in @other
    get squad_path(@squad)
    assert_response :forbidden
  end

  test 'anonymous users cannot create a squad' do
    assert_no_difference 'Squad.count' do
      post squad_index_path, params: { chosenVenues: [@venue.id] }, as: :json
      assert_response :unauthorized
    end
  end

end
