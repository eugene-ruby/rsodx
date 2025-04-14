require "sequel"

module Rsodx
  module Connect
    def self.connect(url)
      raise "Missing DATABASE_URL" unless url

      db = Sequel.connect(url)
      Sequel::Model.db = db
      db
    end
  end
end
