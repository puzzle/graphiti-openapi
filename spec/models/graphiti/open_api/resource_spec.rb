require "spec_helper"

RSpec.describe Graphiti::OpenApi::Resource do
  subject(:instance) { Graphiti::OpenApi::Generator.new(schema: graphiti_schema).resources.by_model("Entity") }

  it { is_expected.to be_a described_class }
end
