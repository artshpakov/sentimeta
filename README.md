# Sentimeta

## Installation

Add this line to your application's Gemfile:

    gem 'sentimeta'

And then execute:

    $ bundle

## Usage

```ruby
Sentimeta.env   = :staging # :production is default
Sentimeta.lang  = :en # default is I18n.locale if defined

# client can be used directly (fetch criteria, spheres, catalog & objects)
spheres = Sentimeta::Client.spheres
Sentimeta.sphere = spheres.first['name'] # pick a specific sphere

# or via subclassing Sentimeta::Model
class Criterion < Sentimeta::Model
  endpoint :criteria # send requests to /api/v1/#{Sentimeta.sphere}/criteria
  attr_accessor :name, :label, :subcriteria

  def self.all
    fetch subcriteria: true
  end

  def self.leafs
    all.flat_map do |root|
      root.subcriteria.map { |sub| new sub }
    end
  end
end

criteria = Criterion.leafs # an array of Criterion class instances

# to fetch raw data
presets = Sentimeta::Client.fetch subcriteria: true 'infotext' {design: "std", param: "main", lang: "en"}
```
