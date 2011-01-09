require 'bundler'
Bundler.setup

require 'rack/aggregate'

[ STDOUT, STDERR ].each { |io| io.sync = true }

def respond_with(status=200, headers={}, body=['Hello World'])
  called = false
  @app = lambda do |env|
    called = true
    response = Rack::Response.new(body, status, headers)
    request = Rack::Request.new(env)

    yield request, response if block_given?

    response.finish
  end

  @app
end

def request(method, uri='/', opts={})
  opts = {
    'rack.run_once' => true,
    'rack.errors' => @errors,
  }.merge(opts)

  @aggregate ||= Rack::Aggregate::Context.new(@app)
  @request = Rack::MockRequest.new(@aggregate)

  yield @aggregate if block_given?

  @request.request(method.to_s.upcase, uri, opts)
end

def get(uri, env={}, &b)
  request(:get, uri, env, &b)
end