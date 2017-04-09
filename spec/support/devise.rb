require 'support/devise_user'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include DeviseUser::Helpers, type: :controller
  config.include DeviseUser::Helpers, type: :concept
  config.include Devise::Test::ControllerHelpers, type: :view
end
