require "rails"
require "graphiti"

module Graphiti
  module OpenApi
    class Engine < ::Rails::Engine
      isolate_namespace Graphiti::OpenApi
    end
  end
end
