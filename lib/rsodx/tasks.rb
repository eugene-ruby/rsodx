return unless defined?(Rake::DSL) rescue false
include Rake::DSL if defined?(Rake::DSL)

require "sequel/extensions/migration"

namespace :db do
  task :migrate do
    Sequel::Migrator.run(DB.connect, "db/migrations")
  end

  task :rollback do
    target = Sequel::Migrator.apply(DB.connect, "db/migrations", :down) - 1
    Sequel::Migrator.run(DB.connect, "db/migrations", target: target)
  end
end
