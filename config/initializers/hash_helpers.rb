class Hash
  def with_defaults(defaults)
    self.merge(defaults) { |key, old, new| old.nil? ? new : old } 
  end

  def with_defaults!(defaults)
    self.merge!(defaults) { |key, old, new| old.nil? ? new : old }
  end
end
