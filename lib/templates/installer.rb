root = File.expand_path('../..', __dir__)

say 'Copying openapi.yml to config/'
copy_file "#{root}/config/openapi.yml", 'config/openapi.yml'
