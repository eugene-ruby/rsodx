require "sequel/extensions/migration"

module Rsodx::Cli::Commands::Db
  class Migrate < Dry::CLI::Command
    desc "Migrate"

    def call(*)
      project_root = Rsodx.project_root
      environment_path = File.join(project_root, "config", "environment.rb")

      unless File.exist?(environment_path)
        abort "❌ Could not find config/environment.rb in #{project_root}"
      end

      require environment_path

      Sequel::Migrator.run(Rsodx::Connect.db, "db/migrations")
    end
  end
end
