require 'rubygems'
require 'rack'

$LOAD_PATH.unshift 'lib'
$LOAD_PATH.unshift 'examples'

require 'rack/aggregate'

class SomeApp
  def call(env)
    sleep(rand(10))
    [200, {"Content-Type" => "text/plain"}, "Hello World"]
  end
end

builder = Rack::Builder.new do
  use Rack::CommonLogger
  use Rack::Aggregate

  run SomeApp.new
end

Rack::Handler::Thin.run builder.to_app, :Port => 4567