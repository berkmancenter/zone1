require 'spec_helper'

describe Right do
  it { should validate_presence_of :action }
  it { should have_many :right_assignments }
  it { should allow_mass_assignment_of :action }
  it { should allow_mass_assignment_of :description }
  it { should allow_mass_assignment_of :role_ids }

end
