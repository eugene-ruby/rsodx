require "interactor"
require "json"
module Rsodx
  class Interactor
    include ::Interactor

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
      context.fail!(error_code: code, error: Rsodx::Error::ContractError.new(message))
    end

    private

    def log_error(code, message)
      puts JSON.pretty_generate({
                                  level: "error",
                                  code: code,
                                  message: message,
                                  context: context.to_h,
                                  backtrace: caller
                                })
    end
  end
end
