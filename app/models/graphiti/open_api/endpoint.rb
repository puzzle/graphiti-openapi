require "graphiti/open_api"
require_relative "struct"
require_relative "action"

module Graphiti::OpenApi
  class EndpointData < Struct
    attribute :actions, Types::Hash.map(Types::Symbol, ActionData)

    def actions
      Actions.load(self)
    end

    memoize :actions
  end

  class Endpoint < EndpointData
    PATH_PARAM_REGEXP = %r{/([^/]+)/1/}

    attribute :schema, Types::Any
    attribute :path, Types::Coercible::String

    def resource_path
      File.join(path.to_s, "{id}")
    end

    def paths
      {
        parameterize(path) => collection_actions.map do |action|
          action.operation.tap do |operation|
            operation[action.method] = operation[action.method].merge({
              parameters: parameters(action),
            })
          end
        end.inject(&:merge).merge(parameters: path_parameters),
        parameterize(resource_path) => (resource_actions.map do |action|
          action.operation.tap do |operation|
            operation[action.method] = operation[action.method].merge({
              parameters: parameters(action),
            })
          end
        end.inject(&:merge).merge(parameters: path_parameters) if resource_actions.any?),
      }.compact
    end

    def parameters(action)
      [].tap do |parameters|
        parameters << {'$ref': "#/components/parameters/#{resource.type}_id"} if action.resource?
        parameters << {'$ref': "#/components/parameters/#{type}_include"} if resource.relationships? && action.read?
        parameters << {'$ref': "#/components/parameters/#{type}_sort"} if action.read?
        parameters << {'$ref': "#/components/parameters/#{type}_fields"} if action.read?
        parameters << {'$ref': "#/components/parameters/#{type}_extra_fields"} if resource.extra_attributes.any? && action.read?
        resource.query_filter_parameters.each do |parameter|
          next if action.resource? && parameter[:name].start_with?("filter[id]")
          filter_name = "#{type}_#{parameter[:name]}".gsub('[', "_").gsub(']', "")
          parameters << {'$ref': "#/components/parameters/#{filter_name}"}
        end if action.read?

        resource.relationships.values.map do |relationship|
          relationship.resources.each do |resource|
            parameters << {'$ref': "#/components/parameters/#{resource.type}_fields"}
          end
        end if action.read?
      end.uniq
    end

    def resource
      actions.first.resource
    end

    def_instance_delegators :resource, :type

    def resource_actions
      actions.reject(&:collection?)
    end

    def collection_actions
      actions.select(&:collection?)
    end

    def path_parameters
      match = path.match(PATH_PARAM_REGEXP)
      return [] unless match
      match.captures.map do |param_type|
        singular_type = param_type.singularize
        resource.path_parameter(:"#{singular_type.underscore}_id", schema: {type: :string}, description: "ID of the #{singular_type.humanize}")
      end
    end

    def parameterize(path)
      path.gsub(PATH_PARAM_REGEXP) { "/#{$1}/{#{$1.singularize.underscore}_id}/" }
    end

    memoize :resource_path, :paths, :parameters, :resource, :resource_actions, :collection_actions
  end

  class Endpoints < Hash
    def self.load(schema, data: schema.__attributes__[:endpoints])
      data.each_with_object({}) do |(path, data), result|
        result[path] = Endpoint.new(data.to_hash.merge(schema: schema, path: path))
      end
    end
  end
end
