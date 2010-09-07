# encoding: utf-8

module DataMapper
  class Query
    module Conditions

      AbstractComparison.class_eval do
        # @api private
        def to_mongo_hash
          {subject.name => {"$#{slug}" => value}}
        end
      end

      EqualToComparison.class_eval do
        # @api private
        def to_mongo_hash
          {subject.name => value}
        end
      end

      LikeComparison.class_eval do
        # @api private
        def to_mongo_hash
          raise NotImplementedError, "`like` comparison is not implemented in mongodb. You could use Regular Expressions instead."
        end
      end

      RegexpComparison.class_eval do
        # @api private
        def to_mongo_hash
          {subject.name => value}
        end
      end

    end # Conditions
  end # Query
end # DataMapper
