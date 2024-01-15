RSpec.describe Graphiti::OpenApi do
  it "is namespaced" do
    expect(Graphiti::OpenApi).to be_a Module
  end

  it "has a version number" do
    expect(Graphiti::OpenApi::VERSION).not_to be nil
  end
end
