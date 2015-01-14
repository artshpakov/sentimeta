module Sentimeta
  module Client
    module Auth

      def user token
        Sentimeta.sphere = :auth
        Sentimeta::Client.get(:users, id: token)
      end

    end
  end
end
