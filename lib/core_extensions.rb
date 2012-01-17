class Hash
  #pass single or array of keys, which will be removed, returning the remaining hash
  def remove!(*keys)
    keys.each{|key| self.delete(key) }
    self
  end

  #non-destructive version
  def remove(*keys)
    self.dup.remove!(*keys)
  end
  
  def with_defaults(defaults)
    self.merge(defaults) { |key, old, new| old.nil? ? new : old } 
  end

  def with_defaults!(defaults)
    self.merge!(defaults) { |key, old, new| old.nil? ? new : old }
  end
end


class Array
  # from http://snippets.dzone.com/posts/show/4805
  # usage: [1, 2, 3].map_to_hash { |e| {e => e + 100} } # => {1 => 101, 2 => 102, 3 => 103}
  def map_to_hash
    map { |e| yield e }.inject({}) { |carry, e| carry.merge! e }
  end
end



class ActiveRecord::Base  
  attr_accessor :accessible #used to dynamically assign accessible attributes 
  
  private  
  
  #used to dynamically assign accessible attributes
  def mass_assignment_authorizer(role = :default) 
    if accessible == :all  
      self.class.protected_attributes  
    else  
      super(role) + (accessible || [])  
    end  
  end  
end  
