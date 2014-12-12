module Sentimeta
  class Observers

    def self.all
      @observers ||= []
    end

    def self.add observer
      all.push observer
    end

  end
end
