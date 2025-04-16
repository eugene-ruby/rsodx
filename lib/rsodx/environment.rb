module Rsodx
  module Environment
    def self.load_dotenv(env = nil)
      require "dotenv"
      Dotenv.load('.env', ".env.#{env}") if env
    end

    def self.load_initializers(app_root)
      Dir[File.join(app_root, "config", "initializers", "*.rb")].sort.each { |file| require file }
    end
  end
end
