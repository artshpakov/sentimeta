module Sentimeta
  module Client
    module Basic

      %i(criteria spheres objects catalog).each do |endpoint|
        define_method endpoint do |options={}|
          Sentimeta::Client.get(endpoint, options)[endpoint.to_s]
        end
      end

      def attributes options={}
        fetch(:attributes, options)['values']
      end

    end
  end
end
