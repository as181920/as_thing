# encoding: utf-8
require "selenium/client"

@selenium = Selenium::Client::Driver.new \
  :host => "localhost",
  :port => 4444,
  :browser => "firefox",
  :url => "http://localhost:3000/",
  :timeout_in_second => 60
@selenium.start_new_browser_session

20.times do |i|
  @selenium.open "/sign_up"
  @selenium.type "id=user_email", "test_user#{i}"
  @selenium.type "id=user_password", "181920"
  @selenium.type "id=user_password_confirmation", "181920"
  @selenium.click "id=user_submit"
  @selenium.wait_for_page_to_load "30000"
end


@selenium.close_current_browser_session



=begin
=end
