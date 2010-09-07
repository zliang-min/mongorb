require 'dm-core'
require 'mongo'

%w[property repository model operation comparison].each { |file| require "mongorb/dm-mongodb-adapter/#{file}" }

class MongodbAdapter < DataMapper::Adapters::AbstractAdapter
  attr_reader :connection, :db

  def initialize(name, options)
    options[:safe_insert] ||= options[:safe] unless false === options[:safe_insert]
    options[:safe_update] ||= options[:safe] unless false === options[:safe_update]
    super
    establish_connection
  end

  def create(resources)
    resources.each do |resource|
      collection_for(resource.model).insert resource.attributes, :safe => @options[:safe_insert]
    end
  end

  def read(query)
    collection_for(query.model).find(
      query.conditions.to_mongo_hash,
      :skip   => query.offset == 0 ? nil : query.offset,
      :limit  => query.limit,
      :fields => query.fields.map { |field| field.name },
      :sort   => query.order.map { |direction| [direction.target.name, direction.operator] }
    )
  end

  def count(query)
    read(query).count
  end

  def update(attributes, collection)
    attributes = attributes.inject({}) do |hash, (property, value)|
      hash[property.name] = value
      hash
    end

    collection_for(collection.model).update collection.query.conditions.to_mongo_hash, attributes, :safe => @options[:safe_update]
  end

  def delete(collection)
    collection_for(collection.model).remove collection.query.conditions.to_mongo_hash
  end

  private

  def establish_connection
    options = {
      :logger    => DataMapper.logger,
      :pool_size => @options[:pool_size],
      :timeout   => @options[:timeout]
    }

    @connection =
      if nodes = @options[:nodes]
        Mongo::Connection.multi(nodes.map! { |node| [node[:host], node[:port]] }, options)
      else
        Mongo::Connection.new @options[:host], @options[:port], options
      end

    @db = @connection.db(
      @options[:database] || @options[:path].gsub('/', ''), 
      :strict => @options[:strict]
    )
  end

  def collection_for(model)
    db[model.storage_name]
  end
end
