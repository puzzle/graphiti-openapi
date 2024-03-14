require "spec_helper"

RSpec.describe Graphiti::OpenApi::Resources do
  subject(:instance) { Graphiti::OpenApi::Generator.new(schema: graphiti_schema).resources }

  describe "#by_model" do
    subject { instance.method(:by_model) }

    its(["Entity"]) { is_expected.to be_a Graphiti::OpenApi::Resource }
  end
end
