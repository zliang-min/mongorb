module Mongorb
  module Conversion
    def to_key
      ['_id'] if persisted?
    end

    def to_param
      _id if persisted?
    end
  end
end
