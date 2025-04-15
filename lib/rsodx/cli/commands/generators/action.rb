module Rsodx::Cli::Commands::Generators
  class Action < Dry::CLI::Command
    desc "Generate full action (controller + serializer + presenter)"

    argument :path, desc: "Path to endpoint (e.g. v1/users/index)"

    def call(args)
      %i[controller serializer presenter].each do |type|
        Rsodx::Cli::Generator.generate(type, args)
      end
    end
  end
end
