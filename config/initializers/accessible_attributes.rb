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
