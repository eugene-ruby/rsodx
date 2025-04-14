# frozen_string_literal: true

Dir[File.join(__dir__, "rsodx/*.rb")].sort.each { |f| require_relative f }
Dir[File.join(__dir__, "rsodx/**/*.rb")].sort.each { |f| require_relative f }

module Rsodx
end
