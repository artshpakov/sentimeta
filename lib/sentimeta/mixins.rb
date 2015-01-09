class Hash

  def to_query
    to_a.map { |e| e.join('=') }.join('&')
  end

end
