require 'oj'
module Rsodx
  class Presenter < Rsodx::Service
    def call
      present
    end

    private

    def present(dto: nil, **options)
      dto ||= context.dto
      Oj.dump(dto, { mode: :compat }.merge(options))
    rescue => e
      raise PresenterError, "Failed to present DTO: #{e.message}"
    end

    class PresenterError < StandardError; end
  end
end
