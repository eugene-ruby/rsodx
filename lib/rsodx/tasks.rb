return unless defined?(Rake::DSL) rescue false
include Rake::DSL if defined?(Rake::DSL)

require "sequel/extensions/migration"

namespace :db do
  task :migrate do
    Sequel::Migrator.run(Rsodx::Connect.db, "db/migrations")
  end

  task :rollback do
    target = Sequel::Migrator.apply(Rsodx::Connect.db, "db/migrations", :down) - 1
    Sequel::Migrator.run(Rsodx::Connect.db, "db/migrations", target: target)
  end
end
