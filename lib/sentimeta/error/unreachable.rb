module Sentimeta
  module Error
    class Unreachable < StandardError

      attr_reader :response

      def initialize msg="Error requesting Sentimeta API", response=nil
        super msg
        @response = response
      end

    end
  end
end
