require "excon_test/version"
require "active_record"
require "carrierwave"
require "fog"

module ExconTest
  module Persistence
    def database_yml
      "#{Dir.pwd}/config/database.yml"
    end

    def database_config
      YAML.load(File.read(database_yml))
    end

    def database_config_for_environment
      database_config[environment]
    end

    def connect_to_persistence
      ActiveRecord::Base.default_timezone = :utc
      ActiveRecord::Base.schema_format    = :ruby
      ActiveRecord::Base.establish_connection(database_config_for_environment)
    end

    def environment
      raise "Method not implemented. Hook method should be instantiated"
    end
  end

  class Application
    extend ExconTest::Persistence

    class << self
      def environment
        ENV["RACK_ENV"] || "development"
      end

      def root
        File.dirname(__FILE__) + "/.."
      end

      def start
        connect_to_persistence
        load_application_files
      end

      private
      def load_application_files
        Dir["#{root}/lib/excon_test/initializers/*.rb"].each {|f| require f}
        Dir["#{root}/lib/excon_test/uploaders/*.rb"].each {|f| require f }
        Dir["#{root}/lib/excon_test/models/*.rb"].each {|f| require f }
      end
    end
  end
end

ExconTest::Application.start