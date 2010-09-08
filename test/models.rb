# encoding: utf-8

class Thing
  include Mongorb::Document

  property :name,   String, :allow_blank => false
  property :number, Integer
end
