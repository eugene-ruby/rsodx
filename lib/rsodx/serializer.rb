module Rsodx
  class Serializer < Rsodx::Service
    def call
      context.dto = serialize_object
    rescue => e
      halt(500, e.message)
    end

    private

    def serialize_object
      case object
      when Hash
        object
      when OpenStruct
        object.to_h
      else
        raise NotSerializableError, "Can't serialize #{object.class.name}"
      end
    end

    class NotSerializableError < StandardError; end
  end
end
