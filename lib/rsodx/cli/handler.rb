require_relative "scaffold"

module Rsodx::Cli
  class Handler
    def self.run
      command = ARGV.shift
      case command
      when "s", "server"
        Rsodx::Cli::Server.run
      when "generate", "g"
        Rsodx::Cli::Generate.run(ARGV)
      when "new"
        name = ARGV.shift
        if name.nil? || name.empty?
          puts "Usage: rsodx new <project_name>"
          exit(1)
        end
        Scaffold.new(name).create
      else
        puts "Unknown command: #{command}"
        puts "Usage: rsodx new <project_name>"
        exit(1)
      end
    end
  end
end
