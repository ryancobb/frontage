module RakeTestHelper
  def self.list_tests
    tests = %x[rake -T | sed -n '/frontend:/{/grep/!p;}' | awk '{print$2}']
    tests.split(" ")
  end

  def self.run(task)
    Thread.new() {
      %x[rake frontend:uptime]
    }
  end
end
