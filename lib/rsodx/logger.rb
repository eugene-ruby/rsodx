require 'json'
require 'time'
require 'syslog/logger'

module Rsodx
  class Logger
    attr_accessor :adapter, :options

    LEVELS = %i[info debug warn error fatal].freeze
    OPTIONS = { with_backtrace: false }.freeze
    LogEntry = Struct.new(:timestamp, :appname, :level, :code, :message, :context, :backtrace)

    def initialize(adapter, options = {})
      raise ArgumentError, 'Invalid LoggerAdapter' unless adapter.is_a?(LoggerAdapter)
      @adapter = adapter
      @options = OPTIONS.merge(options).slice(*OPTIONS.keys)
    end

    def log(level = :info, code:, message:, context: {}, backtrace: nil)
      raise ArgumentError, "Invalid log level: #{level}" unless LEVELS.include?(level)

      entry = LogEntry.new(
        timestamp: Time.now.utc.iso8601,
        appname: appname,
        level: level,
        code: code,
        message: message,
        context: context,
        backtrace: include_backtrace?(level) ? (backtrace || caller).take(10) : nil
      )

      adapter.puts(entry)
    end

    LEVELS.each do |level|
      define_method(level) do |code, message, context = {}|
        log(level, code: code, message: message, context: context)
      end
    end

    private

    def include_backtrace?(level)
      options[:with_backtrace] || level == :debug
    end

    def appname
      Rsodx.config.appname
    end
  end
end
