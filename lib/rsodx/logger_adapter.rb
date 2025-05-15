module Rsodx
  class LoggerAdapter
    def initialize(target)
      @target = target
    end

    def puts(log)
      case @target
      when IO
        @target.puts(log_format(log).to_json)
      when ::Logger
        @target.send(log.level, log_format(log).to_json)
      when Syslog::Logger
        @target.send(log.level, "[#{log.appname}] [#{log.code}] #{log.message} #{log.context}")
      else
        raise "Unsupported log target: #{@target.class}"
      end
    end

    def log_format(log)
      {
        app: log.appname,
        timestamp: log.timestamp,
        level: log.level,
        code: log.code,
        message: log.message,
        context: (log.context.empty? ? nil : log.context),
        backtrace: log.backtrace
      }.compact
    end
  end
end
