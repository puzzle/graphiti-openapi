require "rails_helper"

RSpec.describe Graphiti::OpenApi::Resources do
  subject(:instance) { Graphiti::OpenApi::Generator.new.resources }

  describe "#by_model" do
    subject { instance.method(:by_model) }

    its(["Article"]) { is_expected.to be_a Graphiti::OpenApi::Resource }
  end
end
