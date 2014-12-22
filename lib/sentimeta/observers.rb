module Sentimeta
  class Observers

    @observers = {}

    def self.each &block
      @observers.values.each &block
    end

    def self.add name, observer
      @observers[name] = observer
    end

    def self.get name
      @observers[name]
    end

    def self.method_missing name
      get name
    end

  end
end
