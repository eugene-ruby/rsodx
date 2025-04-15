module Rsodx
  class Action < Rsodx::Service
    delegate :request, :options, :handler_class, to: :context

    before do
      context.options ||= {}
      raise "Missing handler_class in context" unless context.handler_class
    end

    def call
      run_handler
    rescue StandardError => e
      handle_exception(e)
    end

    private

    def run_handler
      result = context.handler_class.call(
        options.merge(request: request, params: request.params)
      )

      return error_result(result) if result.failure?

      serializer = resolve_serializer
      serialized = serializer.call(object: result.object)
      return error_result(serialized) if serialized.failure?

      if presenter_class
        context.json_response = presenter_class.new(serialized.dto).call
      elsif request.request_method == 'POST'
        context.code = 201
      else
        context.code = 204
      end
    end

    def resolve_serializer
      from_handler_with_suffix("Serializer") || AppSerializer
    end

    def presenter_class
      from_handler_with_suffix("Presenter")
    end

    def from_handler_with_suffix(suffix)
      klass_name = handler_class.name.sub(/Controller$/, suffix)
      Object.const_get(klass_name)
    rescue NameError
      nil
    end

    def error_result(result)
      code = result.error_code || 500
      error = result.error || 'Unknown error'
      halt(code, error)
    end

    def handle_exception(e)
      halt(500, e.message)
    end
  end
end
