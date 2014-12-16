module Sentimeta
  module Error
    class RecordNotFound < StandardError

      def initialize msg = "Record not found on API"
        super msg
      end

    end
  end
end
