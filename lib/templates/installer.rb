root = File.expand_path("../..", __dir__)

say "Copying openapi.yml to config/"
copy_file "#{root}/config/openapi.yml", "config/openapi.yml"

say "Ignoring openapi specifications"
File.write ".gitignore", "" unless File.file?(".gitignore")
append_to_file ".gitignore" do
  <<~IGNORE
    public/api/v1/openapi.json
    public/api/v1/openapi.yaml
  IGNORE
end
