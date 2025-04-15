module Rsodx
  class Request
    attr_reader :verb, :path, :request

    def initialize(verb:, path:, request:)
      @verb = verb.to_s.upcase
      @path = path
      @request = request
      @parsed_payload = nil
    end

    def headers
      @headers ||= Rsodx::Headers.new(request)
    end

    def params
      request.params.transform_keys(&:to_sym).merge(payload)
    end

    def payload
      return @parsed_payload if @parsed_payload

      request.body.rewind
      raw = request.body.read.strip

      if raw.empty? || raw == 'null'
        @parsed_payload = {}
      elsif raw.start_with?("{") && raw.end_with?("}")
        begin
          @parsed_payload = JSON.parse(raw, symbolize_names: true)
        rescue JSON::ParserError
          @parsed_payload = {}
        end
      else
        @parsed_payload = {}
      end
    end
  end
end
