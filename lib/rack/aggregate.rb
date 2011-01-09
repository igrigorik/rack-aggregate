require 'rack'
require 'aggregate'

require 'rack/aggregate/context'

module Rack
  module Aggregate
    def self.new(app, options = {}, &blk)
      Context.new(app, options, &blk)
    end
  end
end