require "rack/handler/puma"
module Rsodx::Cli
  class Server
    def self.run
      pid = spawn("bundle exec rake server")
      Process.wait(pid)
      puts "🚀 Starting Rsodx server PID: #{pid} at http://localhost:9292"
    rescue LoadError => e
      abort "❌ Error #{e.message}"
    end
  end
end
