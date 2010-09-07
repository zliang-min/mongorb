# encoding: utf-8

module DataMapper
  Repository.class_eval do
    include Module.new {
      def count(query)
        return 0 unless query.valid?
        adapter.count query
      end
    }
  end
end
