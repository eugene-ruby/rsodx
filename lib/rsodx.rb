# frozen_string_literal: true

require_relative 'rsodx/version'
require_relative 'rsodx/delegate'
require_relative 'rsodx/service'

base = File.expand_path(__dir__)

Dir.glob("#{base}/rsodx/*.rb").sort.each do |file|
  require_relative file.sub("#{base}/", "")
end
Dir.glob("#{base}/rsodx/**/*.rb").sort.each do |file|
  require_relative file.sub("#{base}/", "")
end

module Rsodx
  class << self
    attr_accessor :config

    def configure
      self.config ||= Configuration.new
      yield(config)
    end
  end

  def self.project_root
    @root ||= Dir.pwd
  end

  def self.loader
    @loader ||= begin
                  loader = Zeitwerk::Loader.new

      #  need to be merged with ScaffoldCommon
      %w[
        app/models
        app/services
        app/workers
        app/presenters
        app/serializers
        app/controllers
      ].each do |subdir|
                    path = File.join(project_root, subdir)
                    loader.push_dir(path) if Dir.exist?(path)
                  end

                  loader.enable_reloading
                  loader.setup
                  loader
                end
  end

  def self.reload!
    puts "🔄 Reloading..."
    loader.reload
  end
end

Rsodx.config ||= Rsodx::Configuration.new
Rsodx.loader
