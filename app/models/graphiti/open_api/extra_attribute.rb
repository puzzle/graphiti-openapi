require "graphiti/open_api"
require_relative "struct"

module Graphiti::OpenApi
  class ExtraAttributeData < Struct
    attribute :type, Types::String
    attribute :readable, Types::Bool
    attribute :description, Types::String.optional
  end

  class ExtraAttribute < ExtraAttributeData
    attribute :name, Types::Symbol
    attribute :resource, Types::Any

    def_instance_delegators :resource, :schema

    def type
      schema.types[__attributes__[:type].to_sym]
    end

    def description
      attr_desc = self[:description]&.strip
      attr_desc += '.' unless attr_desc.nil? || attr_desc.end_with?('.')

      extra_field_info =
        <<~DESC
          This *extra field* will only be present if requested explicitely with the `extra_fields[#{resource.type}]` parameter.
          See [Graphiti Resource Extra fields](https://www.graphiti.dev/guides/concepts/resources#extra-fields) for more information.
        DESC

      [
        attr_desc,
        extra_field_info
      ].join(' ')
    end

    def to_property
      return {} unless readable || writable

      definition = type.to_schema
      definition[:description] = description
      definition[:readOnly] = true
      {name => definition}
    end
  end

  class ExtraAttributes < Hash
    def self.load(resource, data = resource.__attributes__[:extra_attributes])
      data.each_with_object(new) do |(name, data), result|
        result[name] = ExtraAttribute.new(data.to_hash.merge(name: name, resource: resource))
      end
    end
  end
end
