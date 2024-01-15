require "rails"
require "responders"
require "graphiti"
require "webpacker"

module Graphiti
  module OpenApi
    class Engine < ::Rails::Engine
      isolate_namespace Graphiti::OpenApi

      initializer "graphiti.openapi.init" do
        Mime::Type.register "text/yaml", :yaml
      end
    end
  end
end
