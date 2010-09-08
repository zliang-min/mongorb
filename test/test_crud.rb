class TestCUD < MiniTest::Unit::TestCase
  setup do
    require 'fixtures'

    @something = Thing.first
  end

  test 'update' do
    id = something._id
    new_number = number + 1
    something.update :number => new_number
    assert_same new_number, Thing.first(id).number
  end

  test 'destroy' do
    somethiThing.first
  end
end

=begin
find_people
find_people :name => Faker::Name.name
find_people :name => Faker::Name.name, :height => 200
find_people :height.gt  => 200
find_people :height.gte => 210
find_people :height.lt  => 160
find_people :height.lte => 150
find_people :height.ne  => 213
find_people :name => [Faker::Name.name, Faker::Name.name, Faker::Name.name]
find_people :height.nin => (170..210).to_a
find_people :height.mod => [2, 1]
find_people :height.size => 200
find_people :height.exists => true
find_people :height.exists => false
find_people :birthday.exists => 1
find_people :birthday.exists => 0
find_people :name => /^b/
find_people :name => /^b/i
find_people :height.not => 200
puts Person.count :height.gt => 210
Person.all(:height.gt => 210).update :height => 210 + rand(10)
Person.all(:height.gt => 210).destroy

puts 'UNION'
puts (Person.all(:height.lt => 160) | Person.all(:height.gt => 210)).map &:attributes

puts "INTERSECTION"
puts (Person.all(:name => /^Mr\./) & (Person.all(:height.lt => 160) | Person.all(:height.gt => 210))).map &:attributes
=end
Person.all(:height.gt => 210).update! :height => 210 + rand(10)
Person.all(:height.gt => 210).destroy!
