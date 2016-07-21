module Firefly
  INVALID_LOGIN_FLASH = "Your username and password do not match our records."

  USERNAME_FIELD = "username"
  PASSWORD_FIELD = "password"
  LOGIN_BUTTON = "Login"
  LOGOUT_BUTTON = "Logout"
  USERNAME = "dobby"
  PASSWORD = "password"

  ### Environment Specific Variables go here. These will overwrite any global variables defined above ###
  case ENV['env']
  when 'qa'
    BASE_URL = "https://qa-app.moneydesktop.com"
  when 'sc'
    BASE_URL = "https://sc-prod-app.moneydesktop.com/"
  end
  ##############################################

  def self.login(username, password)
    ::Capybara::visit Firefly::BASE_URL
    ::Capybara::fill_in Firefly::USERNAME_FIELD, :with => username
    ::Capybara::fill_in Firefly::PASSWORD_FIELD, :with => password
    ::Capybara::click_button Firefly::LOGIN_BUTTON
  end

end
