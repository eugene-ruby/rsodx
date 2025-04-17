require "dry/cli"

module Rsodx::Cli
  module Commands
  end
  module Commands::Generators
  end

  extend Dry::CLI::Registry

  def self.setup!
    register_commands_with_alias(
      group: "",
      alias_prefix: "",
      commands: {
        "db:migrate" => ::Rsodx::Cli::Commands::Db::Migrate
      }
    )

    register_commands_with_alias(
      group: "",
      alias_prefix: "",
      commands: {
        "db:rollback" => ::Rsodx::Cli::Commands::Db::Rollback
      }
    )

    register_commands_with_alias(
      group: "",
      alias_prefix: "",
      commands: {
        "console" => ::Rsodx::Cli::Commands::Console,
        "c"   => ::Rsodx::Cli::Commands::Console
      }
    )

    register_commands_with_alias(
      group: "",
      alias_prefix: "",
      commands: {
        "new" => ::Rsodx::Cli::Commands::Scaffold,
        "n"   => ::Rsodx::Cli::Commands::Scaffold
      }
    )

    register_commands_with_alias(
      group: "generate",
      alias_prefix: "g",
      commands: {
        "migration" => ::Rsodx::Cli::Commands::Generators::Migration,
        "controller" => ::Rsodx::Cli::Commands::Generators::Controller,
        "presenter"  => ::Rsodx::Cli::Commands::Generators::Presenter,
        "serializer" => ::Rsodx::Cli::Commands::Generators::Serializer,
        "action"     => ::Rsodx::Cli::Commands::Generators::Action
      }
    )

    register_commands_with_alias(
      group: "",
      alias_prefix: "",
      commands: {
        "server" => ::Rsodx::Cli::Commands::Server,
        "s"      => ::Rsodx::Cli::Commands::Server
      }
    )
  end

  def self.register_commands_with_alias(group:, alias_prefix:, commands:)
    commands.each do |name, klass|
      full_name = group && !group.empty? ? "#{group} #{name}" : name
      alias_name = alias_prefix && !alias_prefix.empty? ? "#{alias_prefix} #{name}" : name

      register full_name.strip, klass
      register alias_name.strip, klass
    end
  end
end

module Rsodx
  CLI = Dry::CLI.new(::Rsodx::Cli)
end
