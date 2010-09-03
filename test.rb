require_relative 'lib/mongo'
require 'ffaker'

DataMapper::Logger.new $stdout, :debug
DataMapper.setup :default, 'mongodb://localhost/test'

class Person
  include DataMapper::Resource

  property :_id,      BSON::ObjectId
  property :name,     String, :allow_blank => false
  property :birthday, Date
  property :height,   Integer
end

person = Person.new(
  :name => Faker::Name.name,
  :height => rand(80) + 140
)
puts "[SAVE] #{person.save}"

def find_people(conditions = {})
  puts
  puts Person.all(conditions).map &:attributes
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

puts 'UNION'
puts (Person.all(:height.lt => 160) | Person.all(:height.gt => 210)).map &:attributes

puts "INTERSECTION"
puts (Person.all(:name => /^Mr\./) & (Person.all(:height.lt => 160) | Person.all(:height.gt => 210))).map &:attributes
=end
