class Array
  # from http://snippets.dzone.com/posts/show/4805
  # usage: [1, 2, 3].map_to_hash { |e| {e => e + 100} } # => {1 => 101, 2 => 102, 3 => 103}
  def map_to_hash
    map { |e| yield e }.inject({}) { |carry, e| carry.merge! e }
  end
end
