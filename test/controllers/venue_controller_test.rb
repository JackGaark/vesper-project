require 'test_helper'

class VenueControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'visitors can browse venues without cloud credentials' do
    Venue.create!(name: 'Test Venue', description: 'Description', address: 'Address', music_genre: 'Dance')
    get venue_index_path
    assert_response :success
    assert_includes response.body, 'Test Venue'
  end
  test 'ordinary users cannot edit venues' do
    user = User.create!(email: 'user@example.test', password: 'password123')
    venue = Venue.create!(name: 'Protected', description: 'Description', address: 'Address', music_genre: 'Dance')
    sign_in user
    patch venue_path(venue), params: { venue: { description: 'Changed' } }
    assert_response :forbidden
    assert_equal 'Description', venue.reload.description
  end

  test 'home and venue details render without optional venue data' do
    venue = Venue.create!(name: 'Minimal', description: 'Description', address: 'Address', music_genre: 'Dance')
    get root_path
    assert_response :success
    get venue_path(venue)
    assert_response :success
  end

  test 'a visitor can register with email and password' do
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: { email: 'new@example.test', password: 'password123', password_confirmation: 'password123', first_name: 'New', last_name: 'User' } }
      assert_response :redirect
    end
  end

end
