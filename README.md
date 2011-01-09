# Rack Aggregate

Statistics aggregator middleware based on [Joseph Ruscio's aggregate gem](https://github.com/josephruscio/aggregate) which provides: minimum, maximum, mean, standard deviation measures of your applications response latency. Best of all, it accomplishes this without recording or storing any of the actual sample values - meaning, by itself it will not impact your performance or memory footprint even across millions of requests.

## Example

    > ruby examples/rackapp.rb
    > ab -c1 -n20 http://127.0.0.1:4567/ (run 20 requests against the app)
    > ...
    > curl http://127.0.0.1:4567/aggregate

    count:    20
    mean:    4100.30ms
    min:    1000.11ms
    max:    9000.17ms
    std_dev:  2447.42ms

    Request histogram (buckets in ms):
    value |------------------------------------------------------------------| count
      512 |@                                                                 |     1
     1024 |@@@@@@@                                                           |     7
     2048 |@@@@                                                              |     4
     4096 |@@@@@@                                                            |     6
     8192 |@@                                                                |     2
          ~
    Total |------------------------------------------------------------------|    20

### Quickstart with Rack

    gem install rack-aggregate

    # in your rack app / rackup file
    require 'rack/aggregate'
    use Rack::Aggregate

### Quickstart with Rails 3

    # in your Gemfile
    gem 'rack-aggregate', :require => 'rack/aggregate'

    # in development.rb environment
    config.middleware.use Rack::Aggregate

## Wishlist

- Configurable aggregate path
- Custom sampling rate - no need to log every request
- Other output formats? JSON?

# License

(The MIT License)
Copyright © 2011 Ilya Grigorik