# encoding: utf-8

require 'helper'
require 'fixtures'

class TestAdvanceQuery < MiniTest::Unit::TestCase

  test 'eq' do
    count = $fixtures.count { |obj| obj[:number] == 5 }
    assert_same count, Thing.all(:number  => 5).count
  end

  test 'ne' do
    count = $fixtures.count { |obj| obj[:number] != 5 }
    assert_same count, Thing.all(:number.ne => 5).count
  end

  test 'gt' do
    count = $fixtures.count { |obj| obj[:number] > 5 }
    assert_same count, Thing.all(:number.gt  => 5).count
  end

  test 'lt' do
    count = $fixtures.count { |obj| obj[:number] < 5 }
    assert_same count, Thing.all(:number.lt => 5).count
  end

  test 'gte' do
    count = $fixtures.count { |obj| obj[:number] >= 5 }
    assert_same count, Thing.all(:number.gte => 5).count
  end

  test 'lte' do
    count = $fixtures.count { |obj| obj[:number] <= 5 }
    assert_same count, Thing.all(:number.lte => 5).count
  end

  test 'in' do
    names = [Forgery::Name.full_name, Forgery::Name.full_name, Forgery::Name.full_name, Forgery::Name.full_name, Forgery::Name.full_name]
    count = $fixtures.count { |obj| names.include? obj[:name] }
    assert_same count, Thing.all(:name => names).count
  end

  test 'nin' do
    numbers = 3..7
    count = $fixtures.count { |obj| !numbers.cover?(obj[:number]) }
    assert_same count, Thing.all(:number.nin => numbers.to_a).count
  end

  test 'mod' do
    count = $fixtures.count { |obj| obj[:number].odd? }
    assert_same count, Thing.all(:number.mod => [2, 1]).count
  end

  test 'regexp' do
    regexp = /^.a/
    count = $fixtures.count { |obj| obj[:name] =~ regexp }
    assert_same count, Thing.all(:name => regexp).count

    regexp = /^f/i
    count = $fixtures.count { |obj| obj[:name] =~ regexp }
    assert_same count, Thing.all(:name => regexp).count
  end

  test 'exists' do
    count = $fixtures.count { |obj| !obj[:number].nil? }
    assert_same count, Thing.all(:number.exists => true).count
    assert_same count, Thing.all(:number.exists => 1).count

    count = $fixtures.count { |obj| obj[:number].nil? }
    assert_same count, Thing.all(:number.exists => false).count
    assert_same count, Thing.all(:number.exists => 0).count
  end

  test 'size' do
    flunk 'Implement `size` please!'
  end

  test 'type' do
    flunk 'Implement `type` please!'
  end

  test 'not' do
    return flunk 'Implement `not` please!'
    count = $fixtures.count { |obj| obj[:number] != 5 }
    assert_same count, (Thing.all - (Thing.all(:number => 3) & Thing.all(:number.gt => 5) & Thing.all(:name.in => ['a', 'b']))).count
  end

  test 'count' do
    count = $fixtures.count { |obj| obj[:number] != 5 }
    assert_same count, Thing.count(:number.ne => 5)
  end

  test 'limit' do
    assert_same 3, Thing.all(:limit => 3).count
  end

  test 'offset and order' do
    offset = $fixtures.count { |obj| obj[:number] >= 9 }
    value  = $fixtures.map { |obj| obj[:number] }.sort!.uniq!.reverse!.detect { |obj| obj < 9 }

    assert_equal value, Thing.first(:offset => offset, :order => :number.desc).number
  end

  test 'union' do
    count = $fixtures.count { |obj| obj[:number] < 3 or obj[:number] > 7 }
    assert_same count, (Thing.all(:number.lt => 3) | Thing.all(:number.gt => 7)).count
  end

  test 'intersection' do
    regexp = /^f/i
    number = 5

    count = $fixtures.count { |obj| obj[:name] =~ regexp and obj[:number] > number }
    assert_same count, (Thing.all(:name => regexp) & Thing.all(:number.gt => number)).count
  end

  test 'difference' do
    flunk 'Implement `difference` please!'
  end

end
