require 'json'
require_relative "router_dsl"

module Rsodx
  class Router < Base
    include RouterDSL
    set :show_exceptions, false
    set :raise_errors, true

    before do
      content_type :json
    end

    error do
      status 500
      { error: env['sinatra.error'].message }.to_json
    end
  end
end

