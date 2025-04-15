require "fileutils"
require_relative "scaffold_common"

module Rsodx::Cli::Commands
  class Scaffold < Dry::CLI::Command
    include Rsodx::Cli::Commands::ScaffoldCommon
    desc "Scaffold a new Rsodx project"

    argument :name, required: true, desc: "Project name"

    def call(arg)
      @name = arg[:name]
      @app_path = File.join(Dir.pwd, @name)

      puts "🚀 Creating project: #{@name}"
      create_folders
      create_files
      puts "✅ Done! Your project is ready at #{@app_path}"
    rescue => e
      abort "❌ Failed to scaffold: #{e.message}"
    end

    private

    def create_folders
      FOLDERS.each do |path|
        FileUtils.mkdir_p(File.join(@app_path, path))
      end
    end

    def create_files
      write("Gemfile", GEMFILE)
      write(".ruby-version", RUBY_VERSION)
      write(".env", ENVFILE)
      write(".gitignore", GITIGNORE)
      write("config/environment.rb", ENV_LOADER)
      write("Rakefile", RAKEFILE)
      write("app/controllers/app_controller.rb", APP_CONTROLLER)
      write("app/services/app_services.rb", APP_SERVICE)
      write("app/serializers/app_serializer.rb", APP_SERIALIZER)
      write("app/presenters/app_presenter.rb", APP_PRESENTER)
      write("app/app.rb", APP)
      write("app/router.rb", ROUTE)
      write("config/environments/development.rb", "")
      write("config.ru", CONFIGRU)
      write("bin/console", CONSOLE)
      write("bin/rsodx", BINRSODX)

      FileUtils.chmod("+x", File.join(@app_path, "bin/rsodx"))
      FileUtils.chmod("+x", File.join(@app_path, "bin/console"))
    end

    def write(relative_path, content)
      full_path = File.join(@app_path, relative_path)
      File.write(full_path, content)
    end
  end
end
