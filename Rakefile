require "bundler/gem_tasks"
require 'active_support/core_ext/string/strip.rb'
require 'rake'
require 'excon_test'

Rake.load_rakefile "excon_test/tasks.rake"

namespace :db do
  desc "Generate migration Specify name in the NAME variable"
  task :create_migration => :environment do
    name = ENV['NAME'] || raise("Specify name: rake db:create_migration NAME=create_users")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")

    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split("_").map(&:capitalize).join

    File.open(path, 'w') do |file|
      file.write <<-EOF.strip_heredoc
        class #{migration_class} < ActiveRecord::Migration
          def self.up
          end

          def self.down
          end
        end
      EOF
    end

    puts "DONE"
    puts path
  end
end
