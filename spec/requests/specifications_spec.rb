require "rails_helper"

module Graphiti::OpenApi
  RSpec.describe "Specifications", type: :request do
    include Engine.routes.url_helpers

    describe "GET /specifications" do
      it "shows Swagger UI" do
        get specifications_path
        expect(response).to have_http_status(200)
      end

      it "generates JSON OpenApi specification" do
        get specifications_path(format: :json)
        expect(response).to have_http_status(200)
      end

      it "generates YAML OpenApi specification" do
        get specifications_path(format: :yaml)
        expect(response).to have_http_status(200)
      end
    end
  end
end
