class NotifierJob < ApplicationJob  
  queue_as :notifier

  def perform(test_suite_id, num_of_occurences)
    puts "Test Suite ID: #{test_suite_id}, Occurence: #{num_of_occurences}"

    if num_of_occurences > 100
      # SMS
      users = User.joins(:notifications).where("notifications.test_suite_id = ? AND notifications.sms = ?", test_suite_id, true)
      users.each do |user|
        puts "Sending #{user.full_name} a SMS"
      end
    elsif num_of_occurences > 50
      # Email
      users = User.joins(:notifications).where("notifications.test_suite_id = ? AND notifications.email = ?", test_suite_id, true)
      users.each do |user|
        puts "Sending #{user.full_name} an email"
      end
    elsif num_of_occurences > 0
      # Email
      users = User.joins(:notifications).where("notifications.test_suite_id = ? AND notifications.slack = ?", test_suite_id, true)
      ::Notifier.slack(users)
    end
  end
end
