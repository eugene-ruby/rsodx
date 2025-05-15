module Rsodx
  module Environment
    def self.load_dotenv(env = nil)
      require "dotenv"
      Rsodx.instance_variable_set(:@env, env.to_s.freeze) unless Rsodx.instance_variable_defined?(:@env)

      Dotenv.overload(".env.#{env}") if env
    end

    def self.load_initializers(app_root)
      Dir[File.join(app_root, "config", "initializers", "*.rb")].sort.each { |file| require file }
    end

    def self.env
      @env || "development"
    end
  end
end
