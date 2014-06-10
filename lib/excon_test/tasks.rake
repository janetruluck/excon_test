begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

task :rails_env do
  ExconTest::Application.environment
end

task :environment do
  ExconTest::Application.environment
end

module Rails
  class << self
    def application
      Struct.new(:config, :paths) do
        def load_seed
          require File.expand_path('../db/seeds', __FILE__)
        end
      end.new(config, paths)
    end

    def config
      Struct.new(:database_configuration).new(
        ExconTest::Application.database_config_for_environment
      )
    end

    def paths
      { 'db/migrate' => ["#{root}/db/migrate"] }
    end

    def env
      ActiveSupport::StringInquirer.new(ExconTest::Application.environment)
    end

    def root
      ExconTest::Application.root
    end
  end
end

Rake.load_rakefile "active_record/railties/databases.rake"
include ActiveRecord::Tasks
DatabaseTasks.database_configuration = ExconTest::Application.database_config
DatabaseTasks.db_dir = "#{Dir.pwd}/db"
