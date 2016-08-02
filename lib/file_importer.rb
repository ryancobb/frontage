class FileImporter
  def self.import(relative_path)
    doc = File.open(relative_path) { |f| Nokogiri::XML(f)}

    doc.xpath("//testsuite").each do |doc_suite|
      doc_suite_name = doc_suite.at_xpath("@name").value
      doc_suite_timestamp = doc_suite.at_xpath("@timestamp").value.to_time

      testsuite = TestSuite.find_or_create_by(:name => doc_suite_name)
      testsuiterun = testsuite.test_suite_runs.find_or_create_by(:timestamp => doc_suite_timestamp, :test_suite_id => testsuite.id) do |tsr|
        tsr.tests = doc_suite.at_xpath("@tests").value
        tsr.time = doc_suite.at_xpath("@time").value
        tsr.failures = doc_suite.at_xpath("@failures").value
        tsr.errs = doc_suite.at_xpath("@errors").value
        tsr.skipped = doc_suite.at_xpath("@skipped").value
        tsr.timestamp = doc_suite_timestamp
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
        :msg => doc_testcase.xpath("error").last.at_xpath("@message").value
      }
    end
  end
end
