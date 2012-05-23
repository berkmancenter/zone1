require 'spec_helper'

describe Role do
  it "should validate uniqueness of :name" do
    FactoryGirl.create(:role)
    should validate_uniqueness_of(:name)
  end

  it { should validate_presence_of :name }
  it { should have_many(:right_assignments) }
  it { should have_many(:rights).through(:right_assignments) }

  it { should allow_mass_assignment_of :name} 
  it { should allow_mass_assignment_of :right_ids}

  pending "should return array of Right objects from cached self.user_rights method"

end
