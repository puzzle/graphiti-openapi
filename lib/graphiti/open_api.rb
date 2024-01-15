require "graphiti/open_api/version"
require "active_support"

module Graphiti
  module OpenApi
    class Error < StandardError
    end
  end
end

require "graphiti/open_api/engine"
