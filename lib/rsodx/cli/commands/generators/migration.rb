require "fileutils"
require "time"

module Rsodx
  module Cli
    module Commands
      module Generators
        class Migration < Dry::CLI::Command
          desc "Generate a Sequel migration"

          argument :name, required: true, desc: "Name of the migration"

          def call(name:)
            timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")
            file_name = File.join("db/migrations", "#{timestamp}_#{snake_case(name)}.rb")

            puts "📦 Creating migration: #{file_name}"
            FileUtils.mkdir_p("db/migrations")
            File.write(file_name, MIGRATION_TEMPLATE)

            puts "✅ Done"
          rescue => e
            abort "❌ Failed to generate migration: #{e.message}"
          end

          private

          MIGRATION_TEMPLATE = <<~MIGRATION_TEMPLATE.freeze
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
          MIGRATION_TEMPLATE

          def snake_case(str)
            str.gsub(/::/, '/')
               .gsub(/([A-Z]+)([A-Z][a-z])/,'\\1_\\2')
               .gsub(/([a-z\\d])([A-Z])/,'\\1_\\2')
               .tr("-", "_")
               .downcase
          end
        end
      end
    end
  end
end
