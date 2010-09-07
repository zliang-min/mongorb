# encoding: utf-8

require 'active_support'

require 'mongorb/dm-mongodb-adapter/adapter'

module Mongorb
  extend ActiveSupport::Autoload

  autoload :Conversion
  autoload :Document
end
