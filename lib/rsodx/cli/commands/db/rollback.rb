require "sequel/extensions/migration"

module Rsodx::Cli::Commands::Db
  class Rollback < Dry::CLI::Command
    desc "Rollback"

    def call(*)
      project_root = Rsodx.project_root
      environment_path = File.join(project_root, "config", "environment.rb")

      unless File.exist?(environment_path)
        abort "❌ Could not find config/environment.rb in #{project_root}"
      end

      require environment_path
      migration_table = :schema_migrations
      migration_dir = 'db/migrations'

      versions = Rsodx::Connect.db[migration_table].select(:filename).map { |r| r[:filename] }
      version_numbers = versions.map { |f| f.to_s[/^\d+/].to_i }.sort

      current_version = version_numbers.last
      previous_version = version_numbers[-2] || 0
      Sequel::Migrator.run(Rsodx::Connect.db, migration_dir, target: previous_version)
    end
  end
end
