require "interactor"
require "json"
module Rsodx
  class Service
    include ::Interactor
    extend Delegate

    delegate :params, :object, to: :context
    delegate :log, :info, :debug, :warn, :fatal, :error, to: :logger, prefix: :log

    class << self
      attr_accessor :contract_class

      def contract(&block)
        before do
          self.class.contract_class ||= Class.new(Rsodx::Contract, &block)
          contract = self.class.contract_class.new.call(context.params.to_h)

          if contract.failure?
            halt(400, contract.errors.to_h)
          end
        end
      end
    end

    def halt(code, message)
      log_error(code, message)
      context.fail!(error_code: code, error: message)
      Rsodx.config.logger&.error(code, message, context)
    end

    def logger
      Rsodx.config.logger
    end
  end
end
