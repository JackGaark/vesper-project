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
  test 'Facebook request accepts a Rails CSRF token and rejects a missing token' do
    previous_id, previous_secret = ENV['FB_ID'], ENV['FB_SECRET']
    previous_protection = ActionController::Base.allow_forgery_protection
    ENV['FB_ID'], ENV['FB_SECRET'] = 'test-id', 'test-secret'
    ActionController::Base.allow_forgery_protection = true
    get new_user_session_path
    token = css_select('form[action="/users/auth/facebook"] input[name="authenticity_token"]').first['value']
    post user_facebook_omniauth_authorize_path, params: { authenticity_token: token }
    assert_response :redirect
    assert_match %r{\Ahttps://(www\.)?facebook\.com/}, response.location
    assert_raises(ActionController::InvalidAuthenticityToken) do
      post user_facebook_omniauth_authorize_path
    end
  ensure
    ENV['FB_ID'], ENV['FB_SECRET'] = previous_id, previous_secret
    ActionController::Base.allow_forgery_protection = previous_protection
  end

end
