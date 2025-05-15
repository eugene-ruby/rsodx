require "forwardable"

module Rsodx
  module Delegate
    def delegate(*methods, to:, prefix: nil)
      raise ArgumentError, "Missing target for delegation (to:)" unless to

      mod = Module.new do
        extend Forwardable

        methods.each do |method_name|
          delegated_name = if prefix
                             prefix_str = prefix == true ? to.to_s : prefix.to_s
                             "#{prefix_str}_#{method_name}"
                           else
                             method_name
                           end

          def_delegator to, method_name, delegated_name
        end
      end

      include mod
    end
  end
end
