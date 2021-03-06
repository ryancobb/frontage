class FileImporter
  def self.import(relative_path)
    doc = File.open(relative_path) { |f| Nokogiri::XML(f)}

    doc.xpath("//testsuite").each do |doc_suite|
      doc_suite_name = doc_suite.at_xpath("@name").value
      doc_suite_timestamp = doc_suite.at_xpath("@timestamp").value.to_time

      testsuite = TestSuite.find_or_create_by(:name => doc_suite_name)

      system_out = get_system_out(doc_suite)
      env = get_environment(system_out)
      browser = get_browser(system_out)

      testsuiterun = testsuite.test_suite_runs.find_or_create_by(:timestamp => doc_suite_timestamp, :test_suite_id => testsuite.id) do |tsr|
        puts "Importing Run for Test Suite: #{testsuite.name}"
        tsr.tests = doc_suite.at_xpath("@tests").value
        tsr.time = doc_suite.at_xpath("@time").value
        tsr.failures = doc_suite.at_xpath("@failures").value
        tsr.errs = doc_suite.at_xpath("@errors").value
        tsr.skipped = doc_suite.at_xpath("@skipped").value
        tsr.timestamp = doc_suite_timestamp
        tsr.environment = env
        tsr.browser = browser
      end

      # Create / Update Issue
      unless testsuiterun.passed?
        issue = Issue.find_or_create_by(:test_suite_id => testsuite.id, :active => true)
        issue.num_of_occurences += 1
        issue.save

        # Send Notifications
        NotifierJob.perform_later(testsuite.id, issue.num_of_occurences)
      end

      doc_suite.xpath("testcase").each do |doc_testcase|
        doc_testcase_name = doc_testcase.at_xpath("@name").value
        doc_testcase_time = doc_testcase.at_xpath("@time").value
        errors = set_errors(doc_testcase)

        testcase = TestCase.find_or_create_by!(:name => doc_testcase_name, :test_suite_id => testsuite.id)
        testcaserun = TestCaseRun.find_or_create_by!(:test_case_id => testcase.id, :test_suite_run_id => testsuiterun.id) do |tcr|

          tcr.status = errors[:status]
          tcr.status_msg = errors[:msg]
          tcr.time = doc_testcase_time
        end
      end
    end
  end

  def self.set_errors(doc_testcase)
    if doc_testcase.xpath("error").blank?
      errors = {
        :status => 1,
        :msg => "Passed"
      }
    else
      errors = {
        :status => 0,
        :msg => doc_testcase.xpath("error").last.inner_html
      }
    end
  end

  def self.get_system_out(doc_suite)
    doc_suite.at_xpath("system-out").inner_html
  end

  def self.get_browser(system_out)
    system_out.match(/Browser: (.*)/)[1]
  end

  def self.get_environment(system_out)
    system_out.match(/Environment: (.*),/)[1]
  end
end
