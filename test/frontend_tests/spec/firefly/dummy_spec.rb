require_relative '../spec_helper'
require_all 'test/frontend_tests/feature/firefly'

describe "dummy spec", :type => :feature do

  it "Able to login" do
    Firefly::login(Firefly::USERNAME, Firefly::PASSWORD)
    expect(page). to have_link(Firefly::LOGOUT_BUTTON)
    click_link Firefly::LOGOUT_BUTTON
  end

end
