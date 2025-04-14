module Rsodx::Interactors
  class Healthcheck < Rsodx::Interactor
    def call
      context.data = { ok: true }
    end
  end
end
