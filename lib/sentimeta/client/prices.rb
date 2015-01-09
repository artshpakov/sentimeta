module Sentimeta
  module Client
    module Prices

      def prices options={}
        get :prices, options
      end

    end
  end
end
