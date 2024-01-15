require "graphiti/open_api"
require "dry-types"

module Graphiti::OpenApi
  module Types
    include Dry.Types(default: :nominal)

    Pathname = Types.Constructor(::Pathname, Kernel.method(:Pathname))
  end
end
