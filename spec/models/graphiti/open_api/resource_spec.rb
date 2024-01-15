require "rails_helper"

RSpec.describe Graphiti::OpenApi::Resource do
  subject(:instance) { Graphiti::OpenApi::Generator.new.resources.by_model("Article") }

  it { is_expected.to be_a described_class }
end
