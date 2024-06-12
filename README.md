# Graphiti::OpenApi

OpenAPI 3.0 specification for your ([Graphiti](https://github.com/graphiti-api/graphiti)) JSON:API

## Installation

Add this line to your Rails application's Gemfile:

```ruby
gem 'graphiti-openapi'
```

And then execute:

```bash
bundle
```

Set up environment running

```bash
bin/rails graphiti:openapi:install
```

## Usage

Edit template in `config/openapi.yml` to customize your OpenAPI output. This file will be used as base for resulting
document. Generate it by executing

```bash
bin/rails graphiti:openapi:generate
```

Results will be saved in `public/#{ApplicationResource.endpoint_namespace}/openapi.json` and `.../openapi.yaml`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alsemyonov/graphiti-openapi. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Graphiti::OpenAPI project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/alsemyonov/graphiti-openapi/blob/master/CODE_OF_CONDUCT.md).
