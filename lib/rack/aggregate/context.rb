module Rack
  module Aggregate
    class Context
      AGGREGATE_PATH  = /^\/aggregate/.freeze

      def initialize(app, options = {}, &blk)
        options = {
          # ...
        }.merge(options)

        @app = app
        @aggregate = ::Aggregate.new

        yield self if block_given?
      end

      def call(env)
        if env['PATH_INFO'] =~ AGGREGATE_PATH
          resp = Rack::Response.new('', 200)
          resp['Content-Type'] = 'text/plain'

          [:mean, :min, :max, :std_dev].each do |metric|
            resp.write "#{metric}:   %1.2fms\n" % (@aggregate.send(metric) || 0)
          end

          resp.write "Request histogram:\n"
          resp.write @aggregate.to_s

          return resp.finish
        end

        @status, @headers, @response = @app.call(env)

        [@status, @headers, @response]
      end
    end
  end
end
