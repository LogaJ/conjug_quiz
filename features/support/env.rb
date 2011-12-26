$LOAD_PATH << File.expand_path('../../../', __FILE__)

require 'conjug_quiz_app'
require 'rack/test'
require 'capybara'
require 'capybara/cucumber'

Capybara.run_server = true
Capybara.app = ConjugQuiz
Capybara.app_host = 'http://localhost:9393/'
Capybara.default_driver = :selenium


class ConjugQuizExample

  def app
    @app ||= ConjugQuiz
  end

  include Capybara::DSL
  include Rack::Test::Methods
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  ConjugQuizExample.new
end
