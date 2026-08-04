require "graphiti/open_api"
require_relative "struct"

module Graphiti::OpenApi
  class AttributeData < Struct
    attribute :type, Types::String
    attribute :readable, Types::Bool
    attribute :writable, Types::Bool
    attribute :description, Types::String.optional
  end

  class Attribute < AttributeData
    attribute :name, Types::Symbol
    attribute :resource, Types::Any

    def_instance_delegators :resource, :schema

    def type
      schema.types[__attributes__[:type].to_sym]
    end

    def to_property
      return {} unless readable || writable

      definition = type.to_schema
      definition[:description] = description if description
      # Graphiti reports "guarded" instead of true for conditionally readable/writable
      # attributes, while OpenAPI only allows booleans here.
      definition[:readOnly] = true unless writable
      definition[:writeOnly] = true unless readable
      {name => definition}
    end
  end

  class Attributes < Hash
    def self.load(resource, data = resource.__attributes__[:attributes])
      data.each_with_object(new) do |(name, data), result|
        result[name] = Attribute.new(data.to_hash.merge(name: name, resource: resource))
      end
    end
  end
end
