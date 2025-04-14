require 'json'

module Rsodx
  module RouterDSL
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def route(verb, path, interactor, opts = {})
        define_route(verb, path) do
          payload = begin
                      request.body.rewind
                      JSON.parse(request.body.read, symbolize_names: true)
                    rescue JSON::ParserError
                      {}
                    end

          ctx = {
            params: params.to_h,
            json: payload
          }.merge(opts)

          result = interactor.call(ctx)

          status(result.error_code || 200)

          if result.success?
            { success: true, data: result.data }.to_json
          else
            { success: false, error: result.error }.to_json
          end
        end
      end

      %i[get post put patch delete].each do |verb|
        define_method(verb) do |path, interactor = nil, **opts, &block|
          if interactor
            route(verb, path, interactor, opts)
          else
            super(path, &block)
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
