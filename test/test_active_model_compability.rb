require 'helper'
require 'active_model/lint'

class TestActiveModelCompability < MiniTest::Unit::TestCase
  
  setup do
    @model = Thing.new
  end

  include ActiveModel::Lint::Tests
end
