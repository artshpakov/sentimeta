module Sentimeta::Client::Info
  extend self
  extend Sentimeta::RestClient

  def sphere() Sentimeta.sphere end


  def catalog path=nil
    get :infotext, { lang: Sentimeta.lang, param: "catalog-annotation", data: { path: path }}
  end

  def hints
    get(:infotext, { lang: Sentimeta.lang, design: "std", param: "hints" })['hint1']['multiple']
  end

  def main options
    get :infotext, { lang: Sentimeta.lang, design: 'std', param: 'main' }.merge(options)
  end

  def presets options
    get :infotext, { lang: Sentimeta.lang, design: "std", param: "presets" }.merge(options)
  end

end
