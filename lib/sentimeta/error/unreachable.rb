module Sentimeta
  module Error
    class Unreachable < StandardError

      def initialize msg = "Error requesting Sentimeta API"
        super msg
      end

    end
  end
end
