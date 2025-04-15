module Rsodx::Cli::Commands::Generators
  class Presenter < Dry::CLI::Command
    desc "Generate presenter"

    argument :path, desc: "Path to presenter (e.g. v1/users/index)"

    def call(args)
      Rsodx::Cli::Generator.generate(:presenter, args)
    end
  end
end
