# encoding: utf-8

module DataMapper
  class Property
    class ObjectId < Property
      include PassThroughLoadDump

      primitive BSON::ObjectId
      default   lambda { |resource, property| BSON::ObjectId.new }
      key       true
    end
  end
end
