require "dry/cli"
require "irb"
require "irb/completion"

module Rsodx::Cli::Commands
  class Console < Dry::CLI::Command
    desc "Start the Rsodx development console"

    def call(*)
      project_root = Rsodx.project_root
      environment_path = File.join(project_root, "config", "environment.rb")

      unless File.exist?(environment_path)
        abort "❌ Could not find config/environment.rb in #{project_root}"
      end

      require environment_path

      TOPLEVEL_BINDING.eval('def reload!; Rsodx.reload!; end')

      puts Rsodx::LOGO
      puts "🔬 Welcome to Rsodx console (#{ENV['RACK_ENV'] || 'development'})"
      puts "Tip: access Rsodx modules, models, services, etc."

      ARGV.clear
      IRB.start
    rescue LoadError => e
      abort "❌ Failed to load: #{e.message}"
    rescue StandardError => e
      abort "❌ An error occurred: #{e.message}"
    end
  end
end
