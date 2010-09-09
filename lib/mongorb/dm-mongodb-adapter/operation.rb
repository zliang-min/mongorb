# encoding: utf-8

module DataMapper
  class Query
    module Conditions
      # Operations
      AbstractOperation.class_eval do
        # @api private
        def to_mongo_hash
          inject(BSON::OrderedHash.new) do |hash, operand|
            hash.update operand.to_mongo_hash
          end
        end

        def to_s
          to_mongo_hash.inspect
        end
      end

      OrOperation.class_eval do
        # @api private
        def to_mongo_hash
          {'$or' => inject([]) { |array, operand| array << operand.to_mongo_hash }}
        end
      end

      NotOperation.class_eval do
        # TODO This is not right!
        # @api private
        def to_mongo_hash
          {'$not' => super}
        end
      end

      NullOperation.class_eval do
        # @api private
        def to_mongo_hash; {} end
      end
    end
  end
end
