return unless defined?(Rake::DSL) rescue false
include Rake::DSL if defined?(Rake::DSL)
