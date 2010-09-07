# encoding: utf-8

require 'active_model'

module Mongorb
  module Document
    extend ActiveSupport::Concern

    included do
      include DataMapper::Resource

      include ActiveModel::Validations # valid?
      include ActiveModel::Naming # model_name

      include Mongorb::Conversion

      # every mongodb object has a _id.
      property :_id, BSON::ObjectId
    end

    module InstanceMethods
      def to_model;   self  end

      def persisted?; saved? end
    end # InstanceMethods
  end # Document
end # Mongorb
