ENV["EXCON_DEBUG"] = "true"
ENV["RACK_ENV"]    = "development"

require "excon_test"

file_path = "/Path/To/Your/File"
file      = File.open(file_path)

item        = Item.new(name: "test name")
item.poster = file

item.save!
