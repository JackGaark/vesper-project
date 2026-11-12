require 'test_helper'

class FacebookSignInTest < ActionDispatch::IntegrationTest
  test 'sign in page hides Facebook authentication when credentials are missing' do
    previous_id, previous_secret = ENV['FB_ID'], ENV['FB_SECRET']
    ENV.delete('FB_ID')
    ENV.delete('FB_SECRET')
    get new_user_session_path
    assert_response :success
    assert_select 'form[action="/users/auth/facebook"]', count: 0
    assert_select 'a[href="/users/auth/facebook"]', count: 0
  ensure
    ENV['FB_ID'], ENV['FB_SECRET'] = previous_id, previous_secret
  end

  test 'configured Facebook sign in submits a POST from the sign in page' do
    previous_id, previous_secret = ENV['FB_ID'], ENV['FB_SECRET']
    ENV['FB_ID'] = 'test-id'
    ENV['FB_SECRET'] = 'test-secret'
    get new_user_session_path
    assert_response :success
    assert_select 'form[action="/users/auth/facebook"][method="post"]', minimum: 1
    assert_select 'a[href="/users/auth/facebook"]', count: 0
  ensure
    ENV['FB_ID'], ENV['FB_SECRET'] = previous_id, previous_secret
  end
end
