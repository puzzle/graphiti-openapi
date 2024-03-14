require "spec_helper"

RSpec.describe Graphiti::OpenApi::Resource do
  subject(:instance) { Graphiti::OpenApi::Generator.new(schema: graphiti_schema).resources.by_model("Entity") }

  it { is_expected.to be_a described_class }

  its(:extra_attributes) { is_expected.to include(:computational_expensive_attribute) }

  context "#to_schema" do
    subject(:schema) { instance.to_schema }

    context "extra attribute" do
      it 'property is present' do
        expect(schema.dig("entities", :properties)).to be_key(:computational_expensive_attribute)
      end

      it 'property has "extra field" notice in description' do
        description = schema.dig("entities", :properties, :computational_expensive_attribute, :description)
        expect(description).to match(/will only be present if requested explicitely with the `extra_fields\[entities\]`/)
      end

      it 'is listed in "entities_extra_attribute" enum' do
        expect(schema.dig("entities_extra_attribute", :enum)).to include(:computational_expensive_attribute)
      end
    end
  end
end
