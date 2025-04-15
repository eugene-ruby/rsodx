require "dry/cli"

module Rsodx::Cli::Commands
  class Server < Dry::CLI::Command
    desc "Start the Rsodx development server"

    option :port, type: :integer, default: 9292, desc: "Port to run the server on"
    option :env,  type: :string,  default: "development", desc: "Rack environment"

    def call(args)
      env = args[:env]
      port = args[:port]
      ENV["RACK_ENV"] = env

      rackup_path = File.expand_path("config.ru", Dir.pwd)
      unless File.exist?(rackup_path)
        abort "❌ config.ru not found in #{Dir.pwd}"
      end

      pid = spawn("bundle exec rackup --port=#{port} --host=0.0.0.0 #{rackup_path}")
      puts "🚀 Rsodx started!"
      Process.wait(pid)
    rescue => e
      abort "❌ Failed to start server: #{e.class} - #{e.message}"
    end
  end
end
