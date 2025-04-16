require "sequel"

module Rsodx
  module Connect
    @db = nil

    def self.connect(url = Rsodx.config.database_url)
      raise "Missing DATABASE_URL" unless url
      return @db if @db

      @db = Sequel.connect(url)
      Sequel::Model.db = @db
    end

    def self.db
      @db || connect
    end
  end
end
