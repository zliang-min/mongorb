# encoding: utf-8

require 'active_support'
require 'active_model'

module Mongorb
  module Document
    extend ActiveSupport::Concern

    included do
      include Mongorb::FieldMethods
      include Mongorb::Conversion

      include ActiveModel::Validations # valid?
      include ActiveModel::Naming # model_name
    end

    module InstanceMethods
      def to_model
        self
      end

      def persisted?
        !_id.nil?
      end
    end # InstanceMethods
  end # Document
end # Mongorb
