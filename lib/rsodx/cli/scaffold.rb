module Rsodx::Cli
  class Scaffold
    attr_reader :name

    RUBY_VERSION = "3.4.2".freeze

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
    
    if __FILE__ == $0
      Rsodx::Cli::Handler.run
    end
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
      puts "Tip: access Rsodx modules, models, interactors, etc."

      IRB.start
    CONSOLE

    CONFIGRU = <<~RACK.freeze
      require_relative "./app/app"
      run App
    RACK

    ROUTE = <<~ROUTE.freeze
    class Router < Rsodx::Router
      get "/healthcheck", Rsodx::Interactors::Healthcheck
    end
    ROUTE

    APP = <<~APP.freeze
    require "rsodx"
    require_relative "router"
    
    class App < Rsodx::Base
      use Router
    end
    APP

    APP_INTERACTOR = <<~APP_INTERACTOR.freeze
    class AppInteractor < Rsodx::Interactor
    end
    APP_INTERACTOR

    RAKEFILE = <<~RAKEFILE.freeze
    require_relative "config/environment"
    require "rsodx/tasks"
    RAKEFILE

    ENVFILE = <<~ENVFILE.freeze
    DATABASE_URL=postgres://user:password@localhost:5432/base_development
    ENVFILE

    FOLDERS = %w[app/api app/interactors app/models app/presenters
                 app/serializers config/initializers
                 config/environments db/migrations spec bin].freeze

    def initialize(name)
      @name = name
      @app_path = File.join(Dir.pwd, name)
    end

    def create
      puts "Creating project: #{name}"
      create_folders
      create_files
      puts "✅ Done!"
    end

    def create_folders
      FOLDERS.each do |path|
        FileUtils.mkdir_p(File.join(@app_path, path))
      end
    end

    def create_files
      write("Gemfile", GEMFILE)
      write(".ruby-version", RUBY_VERSION)
      write(".env", ENVFILE)
      write("config/environment.rb", env_loader)
      write("Rakefile", RAKEFILE)
      write("app/interactors/app_interactor.rb", APP_INTERACTOR)
      write("app/app.rb", APP)
      write("app/router.rb", ROUTE)
      write("config/environments/development.rb", "")
      write("config.ru", CONFIGRU)
      write("bin/console", CONSOLE)
      write("bin/rsodx", BINRSODX)
      FileUtils.chmod("+x", File.join(@app_path, "bin/console"))
    end

    def write(relative_path, content)
      full_path = File.join(@app_path, relative_path)
      File.write(full_path, content)
    end

    def env_loader
      <<~RB
        require "rsodx"
        Rsodx::Environment.load_dotenv(ENV["RACK_ENV"] || "development")
        Rsodx::Connect.connect ENV["DATABASE_URL"]
        Rsodx::Environment.load_initializers(File.expand_path("../..", __FILE__))
        Rsodx::Boot.load_app_structure(File.expand_path("../..", __FILE__))
      RB
    end
  end
end
