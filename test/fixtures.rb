require 'models'

$fixtures = []

100.times do
  $fixtures << {:name => Forgery::Name.full_name, :number => Forgery::Basic.number}
end

Thing.repository.adapter.send(:collection_for, Thing).drop
$fixtures.each { |fixture| Thing.create fixture }

