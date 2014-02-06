# Rack::TruncateErrorBody

Truncate HTTP body in error response. This is maybe useful for non-html API server.


## Installation

Add this line to your application's Gemfile:

    gem 'rack-truncate_error_body'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-truncate_error_body

## Usage

in Ruby on Rails:

```ruby
config.middleware.use Rack::TruncateErrorBody, only_cascaded: true, content_type: application/x-msgpack
```

`only_cascaded` option means this middleware affects only response with "X-Cascaded: pass" header. This header is added in 404 RoutingError for example.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
