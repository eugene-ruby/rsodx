module Rsodx::Cli
  class Generate
    def self.run(args)
      type = args.shift
      name = args.shift
      case type
      when "interactor", "in"
        GenerateInteractor.new(name).create
      when "migration"
        GenerateMigration.new(name).create
      else
        puts "Unknown generate type: #{type}"
        exit(1)
      end
    end
  end
end
