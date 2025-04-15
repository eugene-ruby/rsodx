module Rsodx::Cli::Commands::Generators
  class Serializer < Dry::CLI::Command
    desc "Generate serializer"

    argument :path, desc: "Path to serializer (e.g. v1/users/index)"

    def call(args)
      Rsodx::Cli::Generator.generate(:serializer, args)
    end
  end
end
