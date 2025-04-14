module Rsodx
  module Cli
    class GenerateInteractor
      def initialize(name)
        @name = name
        @file_name = File.join("app/interactors", snake_case(name) + ".rb")
      end

      def create
        puts "📦 Creating interactor: #{@file_name}"
        FileUtils.mkdir_p("app/interactors")
        File.write(@file_name, content)
      end

      def content
        <<~RUBY
        class #{@name} < AppInteractor
          def call
            # implement logic here
          end
        end
        RUBY
      end

      def snake_case(str)
        str.gsub(/::/, '/').
          gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr("-", "_").
          downcase
      end
    end
  end
end
