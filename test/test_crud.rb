# encoding: utf-8

require 'helper'
require 'models'

class TestCRUD < MiniTest::Unit::TestCase
  test_order :alpha

  test '1. create' do
    name = Forgery::Name.full_name
    number = Forgery::Basic.number

    thing = Thing.create :name => name, :number => number

    assert thing.persisted?
    refute_nil thing._id

    # I have to admit that this's tricky, I wish there is something like setup(:all) { }
    set :id, thing._id
    set :name,     name
    set :number,   number
  end

  test '2. simple read' do
    refute_nil Thing.get get(:id)
    refute_nil Thing.first(:name => get(:name), :number => get(:number))
    refute_nil Thing.all(:name => get(:name), :number => get(:number)).first
  end

  test '3. update' do
    thing = Thing.get get(:id)
    new_number = thing.number + 1
    thing.update :number => new_number

    assert_same new_number, Thing.get(get(:id)).number
  end

  test '4. destroy' do
    thing = Thing.get get(:id)
    thing.destroy

    assert_nil Thing.get(get(:id))
  end
end
