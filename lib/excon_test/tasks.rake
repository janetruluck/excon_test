begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

task :rails_env do
end

task :environment do
  ENV["RACK_ENV"] ||= 'development'
end

module Rails
  def self.application
    Struct.new(:config, :paths) do
      def load_seed
        require 'excon_test'
        require File.expand_path('../db/seeds', __FILE__)
      end
    end.new(config, paths)
  end

  def self.config
    db_config = YAML.load(File.read("config/database.yml"))
    Struct.new(:database_configuration).new(db_config)
  end

  def self.paths
    { 'db/migrate' => ["#{root}/db/migrate"] }
  end

  def self.env
    env = ENV['RACK_ENV'] || "development"
    ActiveSupport::StringInquirer.new(env)
  end

  def self.root
    File.dirname(__FILE__) + "/../.."
  end
end

Rake.load_rakefile "active_record/railties/databases.rake"
