require "spec_helper"

RSpec.describe Graphiti::OpenApi::Generator do
  subject(:instance) do
    described_class.new(schema: graphiti_schema,
                        jsonapi: jsonapi_schema,)
  end

  its(:resources) { is_expected.to be_a Graphiti::OpenApi::Resources }
  its(:endpoints) { is_expected.to be_a Hash }
  its(:types) { is_expected.to be_a Hash }

  describe "#to_openapi" do
    subject(:output) { instance.to_openapi(format: format) }

    context "(format: :yaml)" do
      let(:format) { :yaml }

      it { is_expected.to match /\Aopenapi:/ }
    end
  end
end
