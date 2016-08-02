require_relative '../spec_helper'
require_all 'test/frontend_tests/feature/firefly'

describe "uptime verification", :type => :feature do

  it "Able to login" do
    Firefly::login(Firefly::USERNAME, Firefly::PASSWORD)
    expect(page). to have_link(Firefly::LOGOUT_BUTTON)
    click_link Firefly::LOGOUT_BUTTON
  end

  it "Invalid login" do
    Firefly::login(Faker::Internet.user_name, Faker::Internet.password)
    expect(page).to have_content(Firefly::INVALID_LOGIN_FLASH)
  end

  it 'Verifies master widget loaded' do
    Firefly::login(Firefly::USERNAME, Firefly::PASSWORD)
    within_frame(find(Raja::IFRAME)) do
      expect(page).to have_css(Raja::TOPBAR)
    end
  end

  it 'Accounts widget loads' do
    Firefly::login(Firefly::USERNAME, Firefly::PASSWORD)
    within_frame(find(Raja::IFRAME)) do
      Raja.click_widget(Widgets::Accounts::TOP_BUTTON)
      expect(page).to have_xpath(Raja.widget_xpath_builder(Widgets::Accounts::WIDGET_CLASS))
    end
  end

  it 'Transactions widget loads' do
    Firefly::login(Firefly::USERNAME, Firefly::PASSWORD)
    within_frame(find(Raja::IFRAME)) do
      Raja.click_widget(Widgets::Transactions::TOP_BUTTON)
      expect(page.body).to have_xpath(Raja.widget_xpath_builder(Widgets::Transactions::WIDGET_CLASS))
    end
  end

  it 'Spending widget loads' do
    Firefly::login(Firefly::USERNAME, Firefly::PASSWORD)
    within_frame(find(Raja::IFRAME)) do
      Raja.click_widget(Widgets::Spending::TOP_BUTTON)
      expect(page).to have_xpath(Raja.widget_xpath_builder(Widgets::Spending::WIDGET_CLASS))
    end
  end

  it 'Budgets widget loads' do
    Firefly::login(Firefly::USERNAME, Firefly::PASSWORD)
    within_frame(find(Raja::IFRAME)) do
      Raja.click_widget(Widgets::Budgets::TOP_BUTTON)
      expect(page).to have_xpath(Raja.widget_xpath_builder(Widgets::Budgets::WIDGET_CLASS))
    end
  end

  it 'Trends widget loads' do
    Firefly::login(Firefly::USERNAME, Firefly::PASSWORD)
    within_frame(find(Raja::IFRAME)) do
      Raja.click_widget(Widgets::Trends::TOP_BUTTON)
      expect(page).to have_xpath(Raja.widget_xpath_builder(Widgets::Trends::WIDGET_CLASS))
    end
  end

  it 'Debts widget loads' do
    Firefly::login(Firefly::USERNAME, Firefly::PASSWORD)
    within_frame(find(Raja::IFRAME)) do
      Raja.click_widget(Widgets::Debts::TOP_BUTTON)
      expect(page).to have_xpath(Raja.widget_xpath_builder(Widgets::Debts::WIDGET_CLASS))
    end
  end

  it 'Net Worth widget loads' do
    Firefly::login(Firefly::USERNAME, Firefly::PASSWORD)
    within_frame(find(Raja::IFRAME)) do
      Raja.click_widget(Widgets::NetWorth::TOP_BUTTON)
      expect(page).to have_xpath(Raja.widget_xpath_builder(Widgets::NetWorth::WIDGET_CLASS))
    end
  end

  it 'Goal widget loads' do
    Firefly::login(Firefly::USERNAME, Firefly::PASSWORD)
    within_frame(find(Raja::IFRAME)) do
      Raja.click_widget(Widgets::Goals::TOP_BUTTON)
      expect(page).to have_xpath(Raja.widget_xpath_builder(Widgets::Goals::WIDGET_CLfsdfsdfASS))
    end
  end
end
