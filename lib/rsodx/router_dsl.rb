require 'json'

module Rsodx
  module RouterDSL
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def route(verb, path, handler_class, options = {})
        define_route(verb, path) do
          req = Request.new(verb: verb, path: path, request: request)
          result = Action.call(request: req, handler_class: handler_class, options: options)

          content_type :json
          status(result.error_code || result.code || 200)

          if result.success?
            result.json_response
          else
            { success: false, error: result.error }.to_json
          end
        end
      end

      %i[get post put patch delete head options].each do |verb|
        define_method(verb) do |path, interactor = nil, **opts, &block|
          if interactor
            route(verb, path, interactor, opts)
          else
            define_route(verb, path, &block)
          end
        end
      end

      def namespace(prefix, &block)
        raise ArgumentError, "Block required for namespace" unless block_given?
        previous = @namespace_prefix || ""
        @namespace_prefix = previous + prefix
        class_eval(&block)
        @namespace_prefix = previous
      end

      def define_route(method, path, *args, &block)
        route_block = block || args.pop
        full_path = (@namespace_prefix || "") + path
        Sinatra::Base.send(method.downcase, full_path, *args, &route_block)
      end
    end
  end
end
