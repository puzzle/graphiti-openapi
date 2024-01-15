Rails.application.routes.draw do
  scope path: ApplicationResource.endpoint_namespace, defaults: {format: :jsonapi} do
    resources :articles

    mount Graphiti::OpenApi::Engine => "/"
  end
end
