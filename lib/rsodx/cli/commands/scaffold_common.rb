module Rsodx::Cli::Commands::ScaffoldCommon
  RUBY_VERSION = "3.4.2".freeze

  GITIGNORE = <<~GITIGNORE.freeze
  .env
  tmp/
  GITIGNORE

  #  path: "../rsodx"
  GEMFILE = <<~GEMFILE.freeze
    source "https://rubygems.org"
  
    gem "rsodx"
    gem "pg"
  GEMFILE

  BINRSODX = <<~BINRSODX.freeze
    #!/usr/bin/env ruby
    
    require "fileutils"
    require "optparse"
    require "rsodx"
    
    Rsodx::Cli.setup!
    Rsodx::CLI.call
  BINRSODX

  CONSOLE = <<~CONSOLE.freeze
    #!/usr/bin/env ruby

    require "irb"
    require "irb/completion"

    def reload!
      puts "🔄 Reloading..."
      load File.expand_path("../config/environment.rb", __dir__)
    end

    require_relative "../config/environment"

    puts "🔬 Welcome to Rsodx console (#{ENV['RACK_ENV'] || 'development'})"
    puts "Tip: access Rsodx modules, models, services, etc."

    IRB.start
  CONSOLE

  CONFIGRU = <<~RACK.freeze
    require_relative "./app/app"
    run App
  RACK

  ENV_LOADER = <<~ENV_LOADER.freeze
    require "rsodx"
    Rsodx::Environment.load_dotenv(ENV["RACK_ENV"] || "development")
    
    Rsodx.configure do |config|
      config.database_url = ENV["DATABASE_URL"]
    end
    Rsodx::Connect.connect

    Rsodx::Environment.load_initializers(File.expand_path("../..", __FILE__))
    Rsodx::Boot.load_app_structure(File.expand_path("../..", __FILE__))
  ENV_LOADER

  ROUTE = <<~ROUTE.freeze
    class Router < Rsodx::Router
    end
  ROUTE

  APP = <<~APP.freeze
    require "rsodx"
    require_relative "../config/environment"
    require_relative "router"
    
    class App < Rsodx::Base
      use Router
    end
  APP

  APP_SERVICE = <<~APP_SERVICE.freeze
    class AppService < Rsodx::Service
    end
  APP_SERVICE

  APP_CONTROLLER = <<~APP_CONTROLLER.freeze
    class AppController < Rsodx::Controller
    end
  APP_CONTROLLER

  APP_SERIALIZER = <<~APP_SERIALIZER.freeze
    class AppSerializer < Rsodx::Serializer
    end
  APP_SERIALIZER

  APP_PRESENTER = <<~APP_PRESENTER.freeze
    class AppPresenter < Rsodx::Presenter
    end
  APP_PRESENTER

  RAKEFILE = <<~RAKEFILE.freeze
    require_relative "config/environment"
    require "rsodx/tasks"
  RAKEFILE

  ENVFILE = <<~ENVFILE.freeze
    DATABASE_URL=postgres://rsodx:paSs4321@localhost:5432/rsodx_development
  ENVFILE

  FOLDERS = %w[app/controllers app/services app/models app/presenters
                 app/serializers config/initializers
                 config/environments db/migrations spec bin].freeze
end
