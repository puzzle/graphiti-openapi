require "graphiti/open_api"
require "forwardable"
require "dry-struct"
require "dry/core/memoizable"
require_relative "types"

module Graphiti::OpenApi
  class Struct < Dry::Struct
    include Dry::Core::Memoizable
    extend Forwardable
  end
end
