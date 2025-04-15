module Rsodx
  class Headers
    attr_reader :headers

    def initialize(request)
      @headers = request.env.each_with_object({}) do |(k, v), memo|
        if k.start_with?("HTTP_")
          key = k.sub(/^HTTP_/, '').split('_').map(&:capitalize).join('-')
          memo[key] = v
        end
      end
    end

    def [](key)
      headers[key]
    end

    def authorization
      headers["Authorization"]
    end

    def bearer_token
      return nil unless authorization&.start_with?("Bearer ")
      authorization.sub("Bearer ", "")
    end

    def to_h
      headers
    end
  end
end
