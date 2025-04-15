require "forwardable"

module Rsodx
  module Delegate
    def delegate(*methods, to:)
      raise ArgumentError, "Missing target for delegation (to:)" unless to

      mod = Module.new do
        extend Forwardable
        def_delegators to, *methods
      end

      include mod
    end
  end
end
