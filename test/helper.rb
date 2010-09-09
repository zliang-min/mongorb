require 'rubygems'
require 'minitest/unit'

require 'forgery'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'mongorb'

DataMapper::Logger.new $stdout, :debug
DataMapper.setup :default, 'mongodb://localhost/test'

class MiniTest::Unit::TestCase
  class << self
    def share_objects
      @share_objects ||= {}
    end

    def setup_hooks
      @setup_hooks ||= []
    end

    def teardown_hooks
      @teardown_hooks ||= []
    end

    def setup(&block)
      setup_hooks << block
    end

    def teardown(&block)
      teardown_hooks << block
    end

    def test(something, &block)
      define_method "test_#{something}", &block
    end

    def test_order(order = nil)
      @test_order ||= order || :random
    end
  end

  def setup
    self.class.setup_hooks.each do |block|
      instance_eval &block
    end
  end

  def teardown
    self.class.teardown_hooks.each do |block|
      instance_eval &block
    end
  end

  def set(key, value)
    self.class.share_objects[key] = value
  end

  def get(key)
    self.class.share_objects[key]
  end
end

MiniTest::Unit.autorun
