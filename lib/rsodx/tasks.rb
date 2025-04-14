return unless defined?(Rake::DSL) rescue false
include Rake::DSL if defined?(Rake::DSL)

require "sequel/extensions/migration"

desc "Запуск Puma-сервера"
task :server do
  sh "bundle exec puma -p 9292 config.ru"
end

namespace :db do
  task :migrate do
    Sequel::Migrator.run(DB.connect, "db/migrations")
  end

  task :rollback do
    target = Sequel::Migrator.apply(DB.connect, "db/migrations", :down) - 1
    Sequel::Migrator.run(DB.connect, "db/migrations", target: target)
  end
end
