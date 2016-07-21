module Raja

  IFRAME = "#md-widget iframe"
  LOADED_CLASS = ".md-widget-loaded"
  TOPBAR = ".md-master-widget-top-bar"

  def self.widget_xpath_builder(widget_css_class)
    "//*[@id='widget-container']/*[@class='md-master-widget-container']/*[contains(@class, '#{widget_css_class}')]"
  end

  def self.click_widget(button)
    Capybara::find(:xpath, "//*[@class='#{button}']/../..").click
  end
end
