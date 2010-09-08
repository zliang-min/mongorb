require 'forgery'
require 'models'

$fixtures = []

100.times do
  $fixtures << {:name => Forgery::Name.full_name, :number => Forgery::Basic.number}
end

Thing.repository.adapter.send(:connection)[Thing.storage_name].drop
Thing.create $fixtures
