require 'spec_helper'

describe RightAssignment do
  it { should belong_to(:right) }
  it { should belong_to(:subject) }
  it { should allow_mass_assignment_of :right_id }
end
