require "fileutils"
require "time"

module Rsodx::Cli
  class GenerateMigration
    def initialize(name)
      @name = name
      @timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")
      @file_name = File.join("db/migrations", "#{@timestamp}_#{snake_case(name)}.rb")
    end

    def create
      puts "📦 Creating migration: #{@file_name}"
      FileUtils.mkdir_p("db/migrations")
      File.write(@file_name, content)
    end

    private

    def content
      <<~RUBY
        Sequel.migration do
          change do
            # create_table(:example) do
            #   primary_key :id
            #   String :name
            #   DateTime :created_at
            #   DateTime :updated_at
            # end
          end
        end
      RUBY
    end

    def snake_case(str)
      str.gsub(/::/, '/')
         .gsub(/([A-Z]+)([A-Z][a-z])/,'\\1_\\2')
         .gsub(/([a-z\\d])([A-Z])/,'\\1_\\2')
         .tr("-", "_")
         .downcase
    end
  end
end
