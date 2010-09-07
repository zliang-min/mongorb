# encoding: utf-8

module DataMapper
  Model.append_extensions Module.new {
    def count(query = nil)
      query = 
        if query.nil? || (query.kind_of?(Hash) && query.empty?)
          self.query
        else
          scoped_query query
        end
      query.repository.count(query)
    end

    # Query with javascript expressions.
    # @param [String, Array]
    def where(query)
    end
  }
end
