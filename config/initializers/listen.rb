require 'file_importer'

listener = Listen.to('test/frontend_tests/reports') do |modified, added, removed|
  unless added.blank?
    relative_path = added.first[/test\/frontend_tests\/reports\/.*/]
    FileImporter.import(relative_path)
  end
end
listener.start
