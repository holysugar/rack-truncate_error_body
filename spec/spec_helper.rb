require 'rack/test'
require 'rack/truncate_error_body'

RSpec.configure do |config|
  config.order = 'random'

  config.include Rack::Test::Methods
end
