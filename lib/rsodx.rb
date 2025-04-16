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
end

Rsodx.config ||= Rsodx::Configuration.new
