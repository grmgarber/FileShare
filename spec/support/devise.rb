RSpec.configure do |config|
  # gg to use devise sign_in method in controller tests
  config.include Devise::Test::ControllerHelpers, :type => :controller
end
