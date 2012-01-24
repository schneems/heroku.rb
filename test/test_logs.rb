require "#{File.dirname(__FILE__)}/test_helper"

class TestLogs < MiniTest::Unit::TestCase

  def test_get_logs
    with_app do |app_data|
      heroku.post_addons(post_addon(app_data['name'], 'logging:basic')
      response = heroku.get_logs(app_data['name'], 'logplex' => true)

      assert_equal(200, response.status)
      assert_match(%r{^https://logplex\.heroku\.com/sessions/[-a-zA-Z0-9]*\?srv=[0-9]*$}, response.body)
    end
  end

  def test_get_logs_app_not_found
    assert_raises(Excon::Errors::NotFound) do
      heroku.get_logs(random_name, 'logplex' => true)
    end
  end

end
