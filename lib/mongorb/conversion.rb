module Mongorb
  module Conversion
    def to_key
      ['_id'] if presisted?
    end

    def to_param
      _id if presisted?
    end
  end
end
