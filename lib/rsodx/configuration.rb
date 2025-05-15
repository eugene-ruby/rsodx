module Rsodx
  class Configuration
    attr_accessor :database_url, :logger, :appname

    def initialize
      @appname = Rsodx::RSODX_NAME
      init_database
      init_logger
    end

    private

    def init_database
      @database_url = ENV['DATABASE_URL']
    end
    def init_logger
      @logger ||= Rsodx::Logger.new(Rsodx::LoggerAdapter.new($stdout))
    end
  end
end
