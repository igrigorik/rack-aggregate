require 'helper'

describe Rack::Aggregate do
  let(:app) { [200, {'Content-Type' => 'text/plain'}, 'Hello World'] }

  describe 'middleware' do
    it 'take a backend and returns a middleware component' do
      Rack::Aggregate.new(app).should respond_to(:call)
    end

    it 'take an existing Aggregate object' do
      a = Aggregate.new
      tmp = Rack::Aggregate.new(app, :aggregate => a)
      tmp.instance_variable_get(:@aggregate).object_id.should == a.object_id
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

    it 'should collect aggregate performance statistics' do
      respond_with(200)

      10.times { get('/some_endpoint') }
      response = get('/aggregate')

      response.status.should == 200
      [:mean, :min, :max, :std_dev].each do |metric|
        response.body.should match(/#{metric}:\s+\d\.\d+/)
      end
    end

  end
end
