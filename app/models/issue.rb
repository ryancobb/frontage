class Issue < ApplicationRecord
  belongs_to :test_suite

  def self.active_issues
    self.where(:active => true)
  end
end
