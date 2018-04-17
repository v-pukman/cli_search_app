require 'logger'

module Initech
  module Logger
    extend self

    def logger
      @@logger ||= ::Logger.new(STDOUT)
    end
  end
end
