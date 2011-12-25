$LOAD_PATH << File.expand_path('../../../../', __FILE__)

require 'conjugquiz_app'
require 'rack/test'
require 'capybara'
require 'capybara/cucumber'

Capybara.app = ConjugQuiz

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
