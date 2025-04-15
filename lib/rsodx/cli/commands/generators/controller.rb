module Rsodx::Cli::Commands::Generators
  class Controller < Dry::CLI::Command
    desc "Generate a controller"

    argument :path, desc: "Path to controller, e.g. v1/users/index"

    def call(args)
      Rsodx::Cli::Generator.generate(:controller, args)
    end
  end
end

