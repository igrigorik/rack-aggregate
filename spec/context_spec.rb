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

  describe 'response' do
    it 'should respond with 200 to requests to the aggregate endpoint' do
      respond_with(200)
      response = get('/aggregate')

      response.status.should == 200
      response.body.should match('Empty histogram')
    end

  end
end
