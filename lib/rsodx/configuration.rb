module Rsodx
  class Configuration
    attr_accessor :database_url

    def initialize
      @database_url = ENV["DATABASE_URL"]
    end
  end
end
