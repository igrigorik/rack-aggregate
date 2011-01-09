module Rack
  module Aggregate
    class Context
      AGGREGATE_PATH  = /^\/aggregate/.freeze

      def initialize(app, options = {}, &blk)
        options = {
          # ...
        }.merge(options)

        @app  = app

        yield self if block_given?
      end

      def call(env)
        if env['PATH_INFO'] =~ AGGREGATE_PATH
          resp = Rack::Response.new('', 200)
          resp['Content-Type'] = 'text/plain'

          return resp.finish
        end

        @status, @headers, @response = @app.call(env)

        [@status, @headers, @response]
      end
    end
  end
end
