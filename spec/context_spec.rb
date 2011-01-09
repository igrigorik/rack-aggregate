require 'helper'

describe Rack::Aggregate do
  let(:app) { [200, {'Content-Type' => 'text/plain'}, 'Hello World'] }

  describe 'middleware' do
    it 'take a backend and returns a middleware component' do
      Rack::Aggregate.new(app).should respond_to(:call)
    end

    it 'take an options Hash' do
      lambda { Rack::Aggregate.new(app, {}) }.should_not raise_error(ArgumentError)
    end
  end
end
